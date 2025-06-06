variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "happy-group"
}

variable "location" {
  description = "Azure Region"
  type        = string
  default     = "East US"
}

variable "bastion_subnet_address_prefix" {
  description = "Address prefix of the Bastion subnet"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the Service"
  type        = string
}