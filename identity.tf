resource "azurerm_user_assigned_identity" "identity" {
  count               = var.ssl_enable ? 1 : 0
  provider            = azurerm.hub
  name                = "${var.project}-${var.usage_name}-${var.env}-agw"
  resource_group_name = var.vnet_rg
  location            = var.location

  tags = var.common_tags
}

data "azurerm_client_config" "current" {}

resource "azurerm_role_assignment" "identity" {
  count        = var.ssl_enable ? 1 : 0
  principal_id = azurerm_user_assigned_identity.identity.principal_id
  scope        = data.azurerm_key_vault.main.id

  role_definition_name = "Key Vault Secrets User"
}
