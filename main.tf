terraform {
  required_version = ">= 1.5.0"
}

module "okta-workforce" {
  source = "./okta-workforce"

  org = var.okta_org
  url = var.okta_url
  key = var.okta_key
}

module "okta-privileged-access" {
  source = "./okta-privileged-access"

  key       = var.opa_key
  secret    = var.opa_secret
  team      = var.opa_team
  host      = var.opa_host
  k8s_group = var.opa_k8s_group

  aws_eks = module.aws-infrastructure.aws_eks
}

module "aws-infrastructure" {
  source = "./aws-infrastructure"

  region           = var.aws_region
  instance_type    = var.aws_instance_type
  linux_image_id   = var.aws_linux_image_id
  windows_image_id = var.aws_windows_image_id

  opa_k8s        = module.okta-privileged-access.opa_k8s
  opa_enrollment = module.okta-privileged-access.opa_enrollment
}
