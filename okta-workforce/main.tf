terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "~> 4.6.1"
    }
  }
}

variable org {}
variable url {}
variable key {}


provider "okta" {
  org_name  = var.org
  base_url  = var.url
  api_token = var.key
}
