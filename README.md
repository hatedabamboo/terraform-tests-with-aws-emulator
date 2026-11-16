# Testing Terraform with AWS Emulator

An AWS stack, built with Terraform, that runs against [AWS Emulator](https://github.com/aws/aws-emulator) to test the changes. Example code for the article "[Testing Terraform with AWS Emulator](notes.hatedabamboo.me/terraform-tests-with-aws-emulator/)."

## Layout

```
.
├── Dockerfile          # builds the AWS Emulator image
├── Makefile            # wraps the terraform and docker commands
└── terraform/          # the Terraform configuration
```

## Prerequisites

- Terraform >= 1.5
- Docker, or the `aws-emulator` package for Linux

## Run it

### 1. Start the emulator

```bash
docker build -t aws-emulator .
docker run --rm -p 9297:9297 aws-emulator -a off
```

Check that it answers:

```bash
curl -sk https://127.0.0.1:9297/__admin/health
```

### 2. Apply the stack

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

Or use the `Makefile` from the repo root: `make init plan apply`.

### 3. Applying a deliberately failing code

```bash
cd terraform
terraform init
terraform plan -var 'enable_failure_demo=true'
terraform apply -var 'enable_failure_demo=true' # it fails
```

## Authentication

**Auth off**
Start the emulator with `-a off`. The provider sends the dummy `test` / `test` keys from `variables.tf`. No signature check runs.

**Signed**
Start the emulator without `-a off`. On start it writes new keys and its certificate under `~/.aws/emulator/9297/`. Point the provider at them with environment variables. Pass empty key variables so the provider reads the file, and set `insecure=false` so it verifies the cert through `AWS_CA_BUNDLE`:

```bash
export AWS_SHARED_CREDENTIALS_FILE=~/.aws/emulator/9297/emulator_credentials
export AWS_CONFIG_FILE=~/.aws/emulator/9297/config
export AWS_CA_BUNDLE=~/.aws/emulator/9297/ca.pem
export AWS_REGION=us-east-1

cd terraform
terraform apply  -var 'access_key=' -var 'secret_key=' -var 'insecure=false'
```

## CI

`.github/workflows/terraform.yml` runs the full flow on GitHub Actions: installs the emulator from its Debian package, start it in *signed mode*, then `init`, `fmt -check`, `validate`, `plan`, and `apply`.
