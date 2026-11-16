provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region

  # The emulator serves HTTPS with a self-signed certificate.
  # Local (-a off): skip verification. CI: set insecure=false and trust the
  # emulator's ca.pem through AWS_CA_BUNDLE instead.
  insecure = var.insecure

  # The emulator uses one IP endpoint. Put the bucket name in the path.
  s3_use_path_style = true

  # Do not call the real AWS or the instance metadata service.
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  skip_region_validation      = true

  # Send every service to the emulator instead of AWS.
  endpoints {
    ec2        = var.emulator_endpoint
    lambda     = var.emulator_endpoint
    iam        = var.emulator_endpoint
    sts        = var.emulator_endpoint
    cloudwatch = var.emulator_endpoint
    logs       = var.emulator_endpoint
    events     = var.emulator_endpoint
    sns        = var.emulator_endpoint
    dynamodb   = var.emulator_endpoint
  }

  default_tags {
    tags = var.tags
  }
}
