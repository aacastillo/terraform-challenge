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
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCtPk9gYXEWLc4E+mzSFDiyA3neq5dV3c5q+u0bYw90xZ3viGvpfto4XfJoKllhbzK3+ZBQOpkctuTcOkkMOoqQwxqKGZ5TJE7UgE6sMIMOz+RUeVnj7RVlsuOS9YJCWrNS4PBq6KeOMNfQbfxDb8aQfaT5EXOIIiNJ37zgP1Bg7ZvPgzl19iFP0xGStppKW2ID7W10Hcizm0+jcDUXBhL4+4LURHHrzSUkLdQdlgI+ahDLa2aCGvQUGTetdZVxswCstvJ1yaL6b739YX4USlu3TlOE9zldjzrwIGwY5ZiT9GOzVp/VClQMww1Rq9fWOSHSAcgEMLvn5CdceqryrMIXh3zb74Tf555Lzp3dY637RSWc1x+5lL2lRl/K0hQY0LM5PQfgbdvv71GVIgtVcoeJdAFfxZqL1mKTL94hqMAdKiW7257G4887i8XTH+dPGx7xOR95qszbKBcOHS5sAqzWS1kEu71eenvj/pG4rm0PgNAd6go3+tzrnVbr5K6ab352oTHxXOXZNH0Szkw1IHC1fh5dbRUOMQoE/v9CoC3tIVfwZYuaZ2QytOktnrm1AIWogiFV08OzrMZQGkCOEgHux/dLkMyVgkl28NmNzuALNkcaMH42gOWS3jirHXwbED66sAK8AQxq25nZDthVGL3qhNJV+/DQtIA8hsNdZSywNQ== bastion-host-key"
  }
}

resource "azurerm_network_interface" "bastion" {
  name                = "bastion-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "bastion-ip-config"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}