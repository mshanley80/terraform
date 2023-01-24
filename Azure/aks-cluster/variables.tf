variable "aks_service_principal_app_id" {
  description = "Azure Kubernetes Service Cluster service principal"
}

variable "aks_service_principal_client_secret" {
  description = "Azure Kubernetes Service Cluster password"
}

# number of user nodes in the k8s cluster
variable "agent_count" {
  default = 2
}

# vm size/type to use for nodes
variable "vm_shape" {
  default = "Standard_B2s"
}

# OS disk space in gb
variable "os_disk_size_gb" {
  default = 30
}

# name of the nodepool
variable "nodepool_name" {
  default = "agentpool"
}

# what type of loadbalancer to use
variable "loadbalancer_sku" {
  default = "standard"
}

# what name to tag the environment with
variable "environment_name" {
  default = "SaltDemo"
}

variable "cluster_name" {
  default = "Salt-aks-demo"
}

variable "dns_prefix" {
  default = "saltdemo"
}

variable "resource_group_location" {
  default     = "eastus"
  description = "Location of the resource group."
}

variable "resource_group_name" {
  default     = "saltdemo"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}

variable "ssh_public_key_string" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCiq2/W4317elo332FmqnAtdxvudnD7+Jk1vqf2qWgSLHoV1xiICdArOzsQUJpYbK35Ky0JAC2aPS26Pm38gvkow+MqWZyw2dcMZJnQFY4dYEP3oMwUgn83Djr3yTaBP59aexT93AMQDgjnWKrG3WWOnkaJ4YMntvGC4aZHOpPbl/mJmuBV2+xHb/otAQpMwPfWX4JPvJB8FBPYH/fW+wdg3GlGj45HC+zerrEI4QctSqJIvyScqYdZ82yjrSgaGSTyF2DUriVMY73Wh/VfgcwDiPDa/NR7IsOpGOUrn1WLirp0dEa3Y+rSqWMyZNBHC/mW1D58ONy6kF9YnSKpUEYP"
}

variable "user_prefix" {
  default = "shanleytest"
}