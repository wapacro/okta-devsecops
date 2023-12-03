output "opa_k8s" {
  value = {
    oidc_issuer_url = oktapam_kubernetes_cluster.opa_k8s_cluster.oidc_issuer_url
    group           = oktapam_kubernetes_cluster_group.opa_k8s_cluster_group.group_name
  }
}

output "opa_enrollment" {
  value = {
    gateway_setup_token                = oktapam_gateway_setup_token.opa_token_gateway_setup.token
    gateway_enrollment_token           = oktapam_resource_group_server_enrollment_token.opa_token_linux_gateways.token
    linux_enrollment_token             = oktapam_resource_group_server_enrollment_token.opa_token_linux_servers.token
    windows_non-ad_enrollment_token    = oktapam_resource_group_server_enrollment_token.opa_token_windows_non-ad.token
    windows_ad-joined_enrollment_token = oktapam_resource_group_server_enrollment_token.opa_token_windows_ad-joined.token
  }
}
