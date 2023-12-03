resource "oktapam_resource_group" "opa_rg_linux" {
  name                            = "rg-linux"
  description                     = "Resource Group containing all Linux-based, OPA-managed Servers"
  delegated_resource_admin_groups = [data.oktapam_group.opa_group_superadmins.id]
}

resource "oktapam_resource_group" "opa_rg_windows" {
  name                            = "rg-windows"
  description                     = "Resource Group containing all Windows-based, OPA-managed Servers"
  delegated_resource_admin_groups = [data.oktapam_group.opa_group_superadmins.id]
}

resource "oktapam_resource_group_project" "opa_rgp_linux_gateways" {
  name           = "rgp-gateways"
  resource_group = oktapam_resource_group.opa_rg_linux.id
}

resource "oktapam_resource_group_project" "opa_rgp_linux_servers" {
  name              = "rgp-servers"
  resource_group    = oktapam_resource_group.opa_rg_linux.id
  account_discovery = true
  gateway_selector  = "gateway=default"
}

resource "oktapam_resource_group_project" "opa_rgp_windows_non-ad" {
  name              = "rgp-non-ad"
  resource_group    = oktapam_resource_group.opa_rg_windows.id
  account_discovery = true
  gateway_selector  = "gateway=default"
}

resource "oktapam_resource_group_project" "opa_rgp_windows_ad-joined" {
  name              = "rgp-ad-joined"
  resource_group    = oktapam_resource_group.opa_rg_windows.id
  account_discovery = false
  gateway_selector  = "gateway=default"
}
