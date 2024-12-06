resource "helm_release" "nginx-ingress" {
  chart = "oci://ghcr.io/nginxinc/charts/nginx-ingress"
  name  = "nginx-ingress"
}

