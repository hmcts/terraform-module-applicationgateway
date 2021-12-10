variable "env" {
  description = "environment, will be used in resource names and for looking up the vnet details"
}

variable "subscription" {
  description = "subscription, will be used for looking up the keyvault details"
}

variable "location" {
  description = "location to deploy resources to"
}

variable "sku_name" {
  description = "name of the SKU to use for Application Gateway"
  default     = "Standard_v2"
}

variable "sku_tier" {
  description = "tier of the SKU to use for Application Gateway"
  default     = "Standard_v2"
}

variable "min_capacity" {
  description = "Minimum capacity for autoscaling"
  default     = 2
}

variable "max_capacity" {
  description = "Maximum capacity for autoscaling"
  default     = 10
}

variable "private_ip_address" {
  description = "IP address to allocate staticly to app gateway, must be in the subnet for the env"
}

variable "destinations" {
  type        = list(string)
  description = "List of IP addresses to direct traffic to"
}

variable "frontends" {}

variable "common_tags" {
  description = "Common Tags"
  type        = map(string)
}
variable "oms_env" {
  description = "Name of the enviornment for log analytics workspace"
}

variable "project" {
  description = "Name of the project"
  type        = string

}
variable "vnet_rg" {
  description = "Name of the virtual Network resource group"
  type        = string
}
variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "Enter log analytics workspace id"
  type        = string
}

variable "enable_multiple_availability_zones" {
  default = false
}

variable "enable_waf" {
  default = false
}

variable "waf_mode" {
  description = "Mode for waf to run in"
  default = "Detection"
}