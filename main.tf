terraform {
  required_version = ">= 1.5.0"
}

module "okta-workforce" {
  source = "./okta-workforce"
}

module "okta-privileged-access" {
  source = "./okta-privileged-access"

  aws_eks = module.aws-infrastructure.aws_eks
}

module "aws-infrastructure" {
  source = "./aws-infrastructure"

  region  = var.aws_region
  opa_k8s = module.okta-privileged-access.opa_k8s
}
