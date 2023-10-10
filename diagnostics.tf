resource "azurerm_monitor_diagnostic_setting" "diagnostic_settings" {
  name                       = "app-gw"
  count                      = length(var.frontends) != 0 ? 1 : 0
  target_resource_id         = azurerm_application_gateway.ag[count.index].id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}

resource "azurerm_monitor_diagnostic_setting" "diagnostics_access_logs_la" {
  count = length(var.frontends) != 0 ? (var.send_access_logs_to_log_analytics ? 1 : 0) : 0

  name                       = "app-gw-log-analytics"
  target_resource_id         = azurerm_application_gateway.ag[count.index].id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "ApplicationGatewayAccessLog"
  }

  enabled_log {
    category = "ApplicationGatewayPerformanceLog"
  }
}

resource "azurerm_monitor_diagnostic_setting" "diagnostics_access_logs_sa" {
  count = length(var.frontends) != 0 ? (var.diagnostics_storage_account_id != null ? 1 : 0) : 0

  name               = "app-gw-storage-account"
  target_resource_id = azurerm_application_gateway.ag[count.index].id
  storage_account_id = var.diagnostics_storage_account_id

  enabled_log {
    category = "ApplicationGatewayAccessLog"
  }

  enabled_log {
    category = "ApplicationGatewayPerformanceLog"
  }
}