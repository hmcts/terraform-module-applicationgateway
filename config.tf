
data "azurerm_subnet" "app_gw" {
  name                 = "aks-appgw"
  resource_group_name  = var.vnet_rg
  virtual_network_name = var.vnet_name
}

resource "azurerm_public_ip" "app_gw" {
  count = length(var.frontends) != 0 ? 1 : 0

  name                = var.pip_name != null ? var.pip_name : "${local.resource_prefix}aks-fe-appgw-${var.env}-pip"
  location            = var.location
  resource_group_name = var.vnet_rg
  sku                 = "Standard"
  allocation_method   = "Static"
  zones               = var.enable_multiple_availability_zones == true ? ["1", "2", "3"] : []
  tags                = var.common_tags
}
