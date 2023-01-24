
# Create resource group
resource "azurerm_resource_group" "tf_rg" {
  name     = "${var.user_prefix}-${var.resource_group_name}"
  location = var.resource_group_location
}

resource "azurerm_kubernetes_cluster" "tf_k8s" {
  name                = "${var.user_prefix}-${var.cluster_name}"
  location            = azurerm_resource_group.tf_rg.location
  resource_group_name = azurerm_resource_group.tf_rg.name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name            = var.nodepool_name
    node_count      = var.agent_count
    vm_size         = var.vm_shape
    os_disk_size_gb = var.os_disk_size_gb
  }

  linux_profile {
    admin_username = "azureuser"
    ssh_key {
      # key_data = file(var.ssh_public_key)
      key_data = var.ssh_public_key_string
    }
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = var.loadbalancer_sku
  }

  service_principal {
    client_id     = var.aks_service_principal_app_id
    client_secret = var.aks_service_principal_client_secret
  }

  tags = {
    environment = var.environment_name
  }
}
