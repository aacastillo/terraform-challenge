output "bastion_subnet_id" {
  value = azurerm_subnet.bastion.id
 }

output "service_subnet_id" {
  value = azurerm_subnet.service.id
}

output "bastion_subnet_address_prefix" {
  value = azurerm_subnet.bastion.address_prefixes[0]
}