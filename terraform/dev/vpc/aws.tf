################################################################################
# AWS ACCOUNT setting
################################################################################

# aws setting
provider aws {
  allowed_account_ids = [var.aws_account_id]
  region              = var.region
  profile             = var.profile
}

data "aws_caller_identity" "current" {
}

variable "region" {
  default = "ap-northeast-2"
}

variable "aws_account_id" {
  default = "388272709061"
}

variable "profile" {
  default = "ekstest-dev"
}


################################################################################
# terraform tfstate setting
################################################################################
terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}

