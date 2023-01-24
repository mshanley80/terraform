
# Create resource group
resource "azurerm_resource_group" "tf_rg" {
  name     = "${var.user_prefix}-${var.resource_group_name}"
  location = var.resource_group_location
}

# Create virtual network
resource "azurerm_virtual_network" "tf_network" {
  name                = "${var.user_prefix}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.tf_rg.location
  resource_group_name = azurerm_resource_group.tf_rg.name
}

# Create subnet
resource "azurerm_subnet" "tf_subnet" {
  name                 = "${var.user_prefix}-subnet"
  resource_group_name  = azurerm_resource_group.tf_rg.name
  virtual_network_name = azurerm_virtual_network.tf_network.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create public IPs
resource "azurerm_public_ip" "tf_public_ip" {
  name                = "${var.user_prefix}-public-ip"
  location            = azurerm_resource_group.tf_rg.location
  resource_group_name = azurerm_resource_group.tf_rg.name
  allocation_method   = "Dynamic"
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "tf_nsg" {
  name                = "${var.user_prefix}-nsg"
  location            = azurerm_resource_group.tf_rg.location
  resource_group_name = azurerm_resource_group.tf_rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create network interface
resource "azurerm_network_interface" "tf_nic" {
  name                = "${var.user_prefix}-nic"
  location            = azurerm_resource_group.tf_rg.location
  resource_group_name = azurerm_resource_group.tf_rg.name

  ip_configuration {
    name                          = "${var.user_prefix}-nicconfig"
    subnet_id                     = azurerm_subnet.tf_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.tf_public_ip.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "tf_connect_nic" {
  network_interface_id      = azurerm_network_interface.tf_nic.id
  network_security_group_id = azurerm_network_security_group.tf_nsg.id
}

# Create virtual machine
resource "azurerm_virtual_machine" "tf_vm" {
  name                  = "${var.user_prefix}-vm"
  location              = azurerm_resource_group.tf_rg.location
  resource_group_name   = azurerm_resource_group.tf_rg.name
  network_interface_ids = [azurerm_network_interface.tf_nic.id]
  vm_size               = "Standard_DS1_v2" # find correct size

  # Delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_os_disk {
    name              = "${var.user_prefix}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  os_profile {
    computer_name  = "${var.user_prefix}-vm"
    admin_username = "azureuser"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = var.ssh_public_key_string
      path = "/home/azureuser/.ssh/authorized_keys"
    }
  }
}
  # Dynamic public ip address retrieved after VM assignment
  data "azurerm_public_ip" "tf_public_ip" {
    name                = azurerm_public_ip.tf_public_ip.name
    resource_group_name = azurerm_resource_group.tf_rg.name

    depends_on = [azurerm_virtual_machine.tf_vm]
  }