provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

module "network" {
  source              = "./modules/network"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "bastion" {
  source              = "./modules/bastion"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = module.network.bastion_subnet_id
  bastion_username    = var.bastion_username
}

module "service" {
  source                        = "./modules/service"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  bastion_subnet_address_prefix = module.network.bastion_subnet_address_prefix
  subnet_id                     = module.network.service_subnet_id
}