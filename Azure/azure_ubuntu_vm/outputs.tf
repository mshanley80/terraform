output "resource_group_name" {
  value = azurerm_resource_group.tf_rg.name
}

output "public_ip_address" {
  value = data.azurerm_public_ip.tf_public_ip[*].ip_address
}
