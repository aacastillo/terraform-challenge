provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
}

module "bastion" {
  source              = "./modules/bastion"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  bastion_username    = var.bastion_username
  bastion_ssh_key     = var.bastion_ssh_key
  subnet_id           = module.network.bastion_subnet_id
}

module "instance" {
  source              = "./modules/instance"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  instance_username   = var.bastion_username
  instance_ssh_key    = var.bastion_ssh_key
  subnet_id           = module.network.instance_subnet_id
  bastion_subnet_cidr = module.network.bastion_subnet_cidr
}