output "opa_k8s" {
  value = {
    oidc_issuer_url = oktapam_kubernetes_cluster.opa_k8s_cluster.oidc_issuer_url
  }
}
