output "aws_eks" {
  value = {
    api_endpoint = aws_eks_cluster.eks_cluster.endpoint
    certificate  = base64decode(aws_eks_cluster.eks_cluster.certificate_authority[0].data)
  }
}
