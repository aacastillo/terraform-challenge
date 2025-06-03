resource "azurerm_network_security_group" "bastion" {
  name                = "bastion-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22" # SSH port
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowPayPal"
    priority                   = 1002
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["443"] # HTTPS port
    destination_address_prefix = "api.paypal.com"
  }
}

resource "azurerm_linux_virtual_machine" "bastion" {
  name                = "bastion-host"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_B1s" # One of the smallest and most cost-effective virtual machine sizes in Azure
  admin_username      = var.bastion_username
  network_interface_ids = [
    azurerm_network_interface.bastion.id,
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

resource "azurerm_network_interface" "bastion" {
  name                = "bastion-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "bastion-ip-config"
    subnet_id                     = azurerm_subnet.bastion.id
    private_ip_address_allocation = "Dynamic"
  }
}