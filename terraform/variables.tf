variable "emulator_endpoint" {
  description = "Base URL of the AWS Emulator. HTTPS on port 9297 (see the Dockerfile). Use 127.0.0.1, not localhost."
  type        = string
  default     = "https://127.0.0.1:9297"
}

variable "region" {
  description = "AWS region. The emulator keeps one region only. Use us-east-1."
  type        = string
  default     = "us-east-1"
}

variable "enable_failure_demo" {
  description = "Create a DynamoDB table with an invalid name."
  type        = bool
  default     = false
}

variable "insecure" {
  description = "Skip TLS verification. True for local -a off. False in CI, where AWS_CA_BUNDLE trusts the emulator cert."
  type        = bool
  default     = true
}

variable "access_key" {
  description = "Access key for the provider. With the emulator in --auth off mode any value works."
  type        = string
  default     = "test"
}

variable "secret_key" {
  description = "Secret key for the provider. With the emulator in --auth off mode any value works."
  type        = string
  default     = "test"
  sensitive   = true
}

variable "project_name" {
  description = "Name prefix for all resources."
  type        = string
  default     = "ttwae" # terraform-tests-with-aws-emulator
}

variable "ami_id" {
  description = "AMI id for the EC2 instance. Emulators use a dummy id."
  type        = string
  default     = "ami-0c55b159cbfafe1f0"
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t3.micro"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for the public subnet."
  type        = string
  default     = "10.0.1.0/24"
}

variable "delete_timeout" {
  description = "Delete timeout for VPC and subnet. The emulator loops on DependencyViolation, so keep this short to fail fast."
  type        = string
  default     = "30s"
}

variable "schedule_expression" {
  description = "EventBridge schedule that triggers the Lambda."
  type        = string
  default     = "rate(5 minutes)"
}

variable "tags" {
  description = "Tags applied to all resources."
  type        = map(string)
  default = {
    Project   = "terraform-tests-with-aws-emulator"
    ManagedBy = "terraform"
  }
}
