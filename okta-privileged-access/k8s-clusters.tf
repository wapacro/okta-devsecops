resource "oktapam_kubernetes_cluster" "opa_k8s_cluster" {
  auth_mechanism = "OIDC_RSA2048"
  key            = "opa-k8s-aws"
  labels         = { env = "development" }
}

resource "oktapam_kubernetes_cluster_group" "opa_k8s_cluster_group" {
  cluster_selector = "env=development"
  group_name       = "everyone"
  claims           = { groups = "everyone" }
}

variable aws_eks {}

resource "oktapam_kubernetes_cluster_connection" "opa_k8s_cluster_connection" {
  cluster_id         = oktapam_kubernetes_cluster.opa_k8s_cluster.id
  api_url            = var.aws_eks.api_endpoint
  public_certificate = var.aws_eks.certificate
}
