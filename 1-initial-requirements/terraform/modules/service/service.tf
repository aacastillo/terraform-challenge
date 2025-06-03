resource "azurerm_network_security_group" "service" {
  name                = "service-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "AllowBastion"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22" # SSH Hopping or HTTPS port for API calls?
    source_address_prefix      = azurerm_subnet.bastion.address_prefixes[0]
    destination_address_prefix = "*"
  }
}

resource "azurerm_linux_virtual_machine" "service" {
  name                = "service"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = var.bastion_username
  network_interface_ids = [
    azurerm_network_interface.instance.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  admin_ssh_key {
    username   = var.bastion_username
    public_key = var.bastion_ssh_key
  }
}

# provide the VM with an IP address within its Subnet
resource "azurerm_network_interface" "service" {
  name                = "service-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "service-ip-config"
    subnet_id                     = azurerm_subnet.service.id
    private_ip_address_allocation = "Dynamic"
  }
}