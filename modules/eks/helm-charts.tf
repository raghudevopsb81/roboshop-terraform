resource "null_resource" "kube-bootstrap" {
  depends_on = [aws_eks_cluster.main, aws_eks_node_group.main]
  provisioner "local-exec" {
    command =<<EOF
aws eks update-kubeconfig  --name ${var.env}-eks
kubectl create ns devops
EOF
  }
}

resource "helm_release" "nginx-ingress" {
  depends_on = [null_resource.kube-bootstrap]
  chart = "oci://ghcr.io/nginxinc/charts/nginx-ingress"
  name  = "nginx-ingress"
  namespace = "devops"
  wait       = true

  values = [
    file("${path.module}/helm-config/nginx-ingress.yml")
  ]
}

## ArgoCD Setup
resource "helm_release" "argocd" {
  depends_on = [null_resource.kube-bootstrap]

  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  wait             = false

  set {
    name  = "global.domain"
    value = "argocd-${var.env}.rdevopsb81.online"
  }

  values = [
    file("${path.module}/helm-config/argocd.yml")
  ]
}
