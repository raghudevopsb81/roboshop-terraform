resource "aws_eks_cluster" "main" {
  name     = "${var.env}-eks"
  role_arn = aws_iam_role.eks-cluster-role.arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }

}

# resource "aws_eks_addon" "vpc-cni" {
#   cluster_name = aws_eks_cluster.main.name
#   addon_name   = "vpc-cni"
#   addon_version = "v1.19.0-eksbuild.1"
# }
#
# resource "aws_eks_addon" "vpc-cni" {
#   cluster_name = aws_eks_cluster.main.name
#   addon_name   = "vpc-cni"
#   addon_version = "v1.19.0-eksbuild.1"
# }








