##################################################################################
# VARIABLES
##################################################################################

variable "aws_terraform_state_bucket" {}

variable "aws_dynamodb_table" {}

variable "aws_region" {}

##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  region = "${var.aws_region}"
}

##################################################################################
# RESOURCES
##################################################################################
resource "aws_dynamodb_table" "terraform_statelock" {
  name           = "${var.aws_dynamodb_table}"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "${var.aws_terraform_state_bucket}"
  acl    = "private"

  # set force_destroy to false when ready for production 
  force_destroy = true

  versioning {
    enabled = true
  }
}
