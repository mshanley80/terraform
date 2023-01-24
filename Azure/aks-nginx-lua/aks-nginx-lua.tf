

data "azurerm_kubernetes_cluster" "tf_k8s" {
  name                = "shanleytest-Salt-aks-demo"
  resource_group_name = "shanleytest-saltdemo"
}

resource "helm_release" "create_ingress_controller" {
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx/"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true
}

resource "helm_release" "deploy_httpbin2022" {
  name             = "httpbin2022"
  repository       = "https://mshanley80.github.io/helm-charts/"
  chart            = "httpbin2022"
  namespace        = "httpbin"
  create_namespace = true
}


