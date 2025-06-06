# CIDR calculator: https://mxtoolbox.com/SubnetCalculator.aspx

resource "azurerm_virtual_network" "main" {
  name                = "main-vnet"
  address_space       = ["10.0.0.0/29"] # Couple of IPs for the VNEt
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Isolated subnets for the Bastion Host and Instance
resource "azurerm_subnet" "bastion" {
  name                 = "bastion-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/32"] # Single IP for the Bastion Host
}

resource "azurerm_subnet" "service" {
  name                 = "service-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/32"] # Single IP for the instance
}