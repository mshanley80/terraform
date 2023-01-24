# vm size/type to use for nodes
variable "vm_shape" {
  default = "Standard_B2s"
}

# OS disk space in gb
variable "os_disk_size_gb" {
  default = 30
}

# what name to tag the environment with
variable "environment_name" {
  default = "SaltDemo"
}

variable "resource_group_location" {
  default     = "eastus"
  description = "Location of the resource group."
}

variable "resource_group_name" {
  default     = "saltdemo_rg"
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