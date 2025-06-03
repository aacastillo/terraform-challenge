variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "Azure Region"
  type        = string
  default     = "East US"
}

variable "bastion_username" {
  description = "Username for the Bastion Host"
  type        = string
}

variable "bastion_ssh_key" {
  description = "SSH Key for the Bastion Host"
  type        = string
}