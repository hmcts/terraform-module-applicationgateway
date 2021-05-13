data "azurerm_key_vault" "main" {
  count = (length(var.frontends) != 0  && var.store_privateip ) ? 1 : 0

  name                = var.vault_name
  resource_group_name = var.key_vault_resource_group
}

resource "azurerm_key_vault_secret" "internal-fe-lb-ip" {
  count = (length(var.frontends) != 0  && var.store_privateip ) ? 1 : 0
  name         = "internal-fe-lb-ip"
  value        = var.private_ip_address
  key_vault_id = data.azurerm_key_vault.main[0].id
}
