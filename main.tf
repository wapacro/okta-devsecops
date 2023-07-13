terraform {
  required_version = ">= 1.5.0"
}

module "aws-infrastructure" {
  source = "./aws-infrastructure"

  region = var.aws_region
}

module "okta-workforce" {
  source = "./okta-workforce"
}
