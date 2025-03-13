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
  default     = []
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
  default     = "Prevention"
}

variable "exclusions" {
  default = []
}

variable "app_gateway_name" {
  description = "The name of the Application Gateway"
  type        = string
  default     = null
}

variable "pip_name" {
  description = "The name of the public ip"
  type        = string
  default     = null
}

variable "pubsub_subnet" {
  description = "Use this subnet for pubsub app gateway"
  type        = bool
  default     = false
}

variable "ssl_enable" {
  type    = bool
  default = false
}

variable "ssl_certificate_name" {
  description = "The name of the ssl_certificate"
  type        = string
}

variable "usage_name" {
  description = "describes usage of app gateway, for use in naming resources"
  default     = "pubsub"
}

variable "vault_name" {
  description = "vault name"
}

variable "key_vault_resource_group" {
  description = "Name of the resource group for the keyvault"
  type        = string
}

variable "waf_policy_name" {
  description = "Name of the waf policy resource group"
  type        = string
  default     = null
}

variable "waf_managed_rules" {
  type = list(object({
    type    = string
    version = string
    rule_group_override = list(object({
      rule_group_name = string
      rule = list(object({
        id      = string
        enabled = bool
        action  = string
      }))
    }))
  }))
  default = null
}

variable "waf_custom_rules" {
  type = list(object({
    name      = string
    priority  = number
    rule_type = string
    match_conditions = list(object({
      match_variables = list(object({
        variable_name = string
        selector      = optional(string)
      }))
      operator           = string
      negation_condition = bool
      match_values       = list(string)
    }))
    action = string
  }))
  default = null
}

variable "pubsubappgw_ssl_policy" {
  description = "Pubsub pplication Gateway SSL configuration"
  type = object({
    disabled_protocols   = optional(list(string))
    policy_type          = optional(string)
    policy_name          = optional(string)
    cipher_suites        = optional(list(string))
    min_protocol_version = optional(string)
  })
  default = null
}