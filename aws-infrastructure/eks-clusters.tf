resource "aws_iam_role" "eks_iam_cluster_role" {
  name               = "eks-cluster-role"
  path               = "/"
  assume_role_policy = <<EOF
  {
   "Version": "2012-10-17",
   "Statement": [
    {
     "Effect": "Allow",
     "Principal": {
      "Service": "eks.amazonaws.com"
     },
     "Action": "sts:AssumeRole"
    }
   ]
  }
  EOF
}

resource "aws_iam_role_policy_attachment" "eks_iam_cluster_role_eks-attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_iam_cluster_role.name
}

resource "aws_iam_role_policy_attachment" "eks_iam_cluster_role_ec2-attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_iam_cluster_role.name
}

resource "aws_default_subnet" "default_subnet_az1" {
  availability_zone = "${var.region}a"
}

resource "aws_default_subnet" "default_subnet_az2" {
  availability_zone = "${var.region}b"
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = "opa-k8s-aws"
  role_arn = aws_iam_role.eks_iam_cluster_role.arn
  vpc_config {
    endpoint_public_access = true
    subnet_ids             = [aws_default_subnet.default_subnet_az1.id, aws_default_subnet.default_subnet_az2.id]
  }
}

variable opa_k8s {}

resource "aws_eks_identity_provider_config" "eks_cluster_idp_config" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  oidc {
    client_id                     = "kubernetes"
    identity_provider_config_name = "okta-privileged-access"
    issuer_url                    = var.opa_k8s.oidc_issuer_url
    username_claim                = "sub"
    groups_claim                  = "groups"
  }
}

data "aws_eks_cluster_auth" "eks_cluster_auth" {
  name = aws_eks_cluster.eks_cluster.name
}

provider "kubernetes" {
  host                   = aws_eks_cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks_cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks_cluster_auth.token
}

resource "kubernetes_cluster_role_binding" "eks_cluster_rolebinding" {
  metadata {
    name = "opa:clusteradmin-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind = "Group"
    name = "everyone"
  }
}
