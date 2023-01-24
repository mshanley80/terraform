
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.66.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.3"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
	helm = {
	  source  = "hashicorp/helm"
      version = ">= 2.6.0"
	}
  }

  required_version = ">= 0.14"
}

provider "azurerm" {
  features {}
}

provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.tf_k8s.kube_config.0.host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.tf_k8s.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.tf_k8s.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.tf_k8s.kube_config.0.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = data.azurerm_kubernetes_cluster.tf_k8s.kube_config.0.host
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.tf_k8s.kube_config.0.client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.tf_k8s.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.tf_k8s.kube_config.0.cluster_ca_certificate)
  }
}

provider "kubectl" {
  host                   = data.azurerm_kubernetes_cluster.tf_k8s.kube_config[0].host
  client_key             = base64decode(data.azurerm_kubernetes_cluster.tf_k8s.kube_config[0].client_key)
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.tf_k8s.kube_config[0].client_certificate)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.tf_k8s.kube_config[0].cluster_ca_certificate)
  load_config_file       = false
}
