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
