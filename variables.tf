variable "env" {
  description = "environment, will be used in resource names and for looking up the vnet details"
}

variable "subscription" {
  description = "subscription, will be used for looking up the keyvault details"
}

variable "location" {
  description = "location to deploy resources to"
}

variable "min_capacity" {
  description = "Minimum capacity for autoscaling"
  default     = 2
}

variable "send_access_logs_to_log_analytics" {
  description = "Send access logs to log analytics workspace, this can be quite expensive on busy instances so disable it and send to Storage account instead"
  default     = false
}

variable "diagnostics_storage_account_id" {
  description = "ID of a storage account to send access logs to."
  default     = null
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

variable "resource_prefix" {
  description = "Optional name prefix for resources"
  type        = string
  default     = null
}

variable "enable_waf" {
  default = false
}

variable "waf_mode" {
  description = "Mode for waf to run in"
  default     = "Detection"
}

variable "exclusions" {
  default = []
}

variable "sku_tier" {
  type = string
}
