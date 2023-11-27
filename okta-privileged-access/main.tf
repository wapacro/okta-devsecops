terraform {
  required_providers {
    oktapam = {
      source  = "okta/oktapam"
      version = "~> 0.4.0"
    }
  }
}

variable key {}
variable secret {}
variable team {}
variable host {}

provider "oktapam" {
  oktapam_key      = var.key
  oktapam_secret   = var.secret
  oktapam_team     = var.team
  oktapam_api_host = var.host
}
