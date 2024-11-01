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

variable "enabled" {
  description = "Is the Web Application Firewall enabled?"
  type        = bool
  default     = false
}

variable "firewall_mode" {
  description = "The Web Application Firewall Mode. Possible values are Detection and Prevention"
  type        = string
  default     = "Detection"
}

variable "rule_set_version" {
  description = "The Version of the Rule Set used for this Web Application Firewall. Possible values are 0.1, 1.0, 2.1, 2.2.9, 3.0, 3.1 and 3.2"
  default     = 3.2
}

variable "rule_set_type" {
  description = "The Type of the Rule Set used for this Web Application Firewall. Possible values are OWASP, Microsoft_BotManagerRuleSet and Microsoft_DefaultRuleSet. Defaults to OWASP."
  type        = string
  default     = "OWASP"
}

variable "file_upload_limit_mb" {
  description = "The File Upload Limit in MB. Accepted values are in the range 1MB to 750MB for the WAF_v2 SKU, and 1MB to 500MB for all other SKUs. Defaults to 100MB."
  type        = string
  default     = "100MB"
}

variable "request_body_check" {
  description = "Is Request Body Inspection enabled? Defaults to true."
  type        = bool
  default     = true
}

variable "max_request_body_size_kb" {
  description = "The Maximum Request Body Size in KB. Accepted values are in the range 1KB to 128KB. Defaults to 128KB."
  type        = string
  default     = "128KB"
}

variable "rule_group_name" {
  description = "The rule group where specific rules should be disabled"
  type        = string
  default     = null
}

variable "rules" {
  description = "A list of rules which should be disabled in that group. Disables all rules in the specified group if rules is not specified."
  default     = null
}

variable "match_variable" {
  description = "Match variable of the exclusion rule to exclude header, cookie or GET arguments"
  default     = null
}

variable "selector_match_operator" {
  description = "Operator which will be used to search in the variable content."
  default     = null
}

variable "selector" {
  description = " String value which will be used for the filter operation. If empty will exclude all traffic on this match_variable"
  default     = null
}
