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

variable "bastion_username" {
  description = "Username for the Bastion Host"
  type        = string
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}