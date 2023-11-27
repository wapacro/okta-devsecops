output "opa_k8s" {
  value = {
    oidc_issuer_url = oktapam_kubernetes_cluster.opa_k8s_cluster.oidc_issuer_url
    group           = oktapam_kubernetes_cluster_group.opa_k8s_cluster_group.group_name
  }
}
