terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "~> 4.6.1"
    }
  }
}

provider "okta" {
  org_name  = ""
  base_url  = "oktapreview.com"
  api_token = ""
}
