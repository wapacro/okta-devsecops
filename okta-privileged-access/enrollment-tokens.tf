resource "oktapam_resource_group_server_enrollment_token" "opa_token_linux_gateways" {
  description    = "Linux Gateways: default-token"
  resource_group = oktapam_resource_group.opa_rg_linux.id
  project        = oktapam_resource_group_project.opa_rgp_linux_gateways.id
}

resource "oktapam_resource_group_server_enrollment_token" "opa_token_linux_servers" {
  description    = "Linux Servers: default-token"
  resource_group = oktapam_resource_group.opa_rg_linux.id
  project        = oktapam_resource_group_project.opa_rgp_linux_servers.id
}

resource "oktapam_resource_group_server_enrollment_token" "opa_token_windows_non-ad" {
  description    = "Windows Non-AD: default-token"
  resource_group = oktapam_resource_group.opa_rg_windows.id
  project        = oktapam_resource_group_project.opa_rgp_windows_non-ad.id
}

resource "oktapam_resource_group_server_enrollment_token" "opa_token_windows_ad-joined" {
  description    = "Windows AD-joined: default-token"
  resource_group = oktapam_resource_group.opa_rg_windows.id
  project        = oktapam_resource_group_project.opa_rgp_windows_ad-joined.id
}

resource "oktapam_gateway_setup_token" "opa_token_gateway_setup" {
  description = "Gateway Setup Token"
  labels      = { gateway : "default" }
}
