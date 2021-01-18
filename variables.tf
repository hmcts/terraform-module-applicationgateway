variable "env" {
  description = "environment, will be used in resource names and for looking up the vnet details"
}

variable "subscription" {
  description = "subscription, will be used for looking up the keyvault details"
}

variable "vault_name" {
  description = "vault name"
}

variable "location" {
  description = "location to deploy resources to"
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

variable "frontends" {
  # type = list(any)

}

variable common_tags {
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
variable "store_privateip" {
  description = "Storage application gateway's private IP in vault?"
  type = bool
  default = false
}
variable "log_analytics_workspace_id" {
  description = "Enter log analytics workspace id"
  type        = string
}