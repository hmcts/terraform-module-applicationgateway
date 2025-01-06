/**
 * # https://github.com/hmcts/terraform-module-applicationgateway
 *
 * Terraform module to create Azure Application Gateway resource.
 *
 *
 */



locals {
  x_fwded_proto_ruleset = "x_fwded_proto"
  resource_prefix       = var.resource_prefix != null ? "${var.resource_prefix}-" : ""
}

resource "azurerm_application_gateway" "ag" {
  name                = var.app_gateway_name != null ? var.app_gateway_name : "${local.resource_prefix}aks-fe-${format("%02d", count.index)}-${var.env}-agw"
  resource_group_name = var.vnet_rg
  location            = var.location
  tags                = var.common_tags
  zones               = var.enable_multiple_availability_zones == true ? ["1", "2", "3"] : []
  firewall_policy_id  = var.enable_waf ? azurerm_web_application_firewall_policy.waf_policy.id : null

  count = length(var.frontends) != 0 ? 1 : 0

  sku {
    name = var.enable_waf == true ? "WAF_v2" : "Standard_v2"
    tier = var.enable_waf == true ? "WAF_v2" : "Standard_v2"
  }

  autoscale_configuration {
    min_capacity = var.min_capacity
    max_capacity = var.max_capacity
  }

  gateway_ip_configuration {
    name      = "gateway"
    subnet_id = data.azurerm_subnet.app_gw.id
  }

  frontend_port {
    name = "http"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "appGwPublicFrontendIp"
    public_ip_address_id = azurerm_public_ip.app_gw[0].id
  }

  frontend_ip_configuration {
    name                          = "appGwPrivateFrontendIp"
    subnet_id                     = data.azurerm_subnet.app_gw.id
    private_ip_address            = var.private_ip_address
    private_ip_address_allocation = "Static"
  }

  dynamic "backend_address_pool" {
    for_each = [for app in var.frontends : {
      name = app.name
    }]

    content {
      name         = backend_address_pool.value.name
      ip_addresses = var.destinations
    }
  }

  dynamic "probe" {
    for_each = [for app in var.frontends : {
      name = app.name
      host = app.custom_domain
      path = lookup(app, "health_path", "/health/liveness")
    }]

    content {
      interval            = 20
      name                = probe.value.name
      host                = probe.value.host
      path                = probe.value.path
      protocol            = "Http"
      timeout             = 15
      unhealthy_threshold = 3
    }
  }

  dynamic "backend_http_settings" {
    for_each = [for app in var.frontends : {
      name                  = app.name
      cookie_based_affinity = try(title(app.appgw_cookie_based_affinity), "Disabled")
    }]

    content {
      name                  = backend_http_settings.value.name
      probe_name            = backend_http_settings.value.name
      cookie_based_affinity = backend_http_settings.value.cookie_based_affinity
      port                  = 80
      protocol              = "Http"
      request_timeout       = 30
    }
  }

  dynamic "http_listener" {
    for_each = [for app in var.frontends : {
      name          = app.name
      custom_domain = app.custom_domain
    }]

    content {
      name                           = http_listener.value.name
      frontend_ip_configuration_name = "appGwPrivateFrontendIp"
      frontend_port_name             = "http"
      protocol                       = "Http"
      host_name                      = http_listener.value.custom_domain
    }
  }

  dynamic "request_routing_rule" {
    for_each = [for i, app in var.frontends : {
      name     = app.name
      priority = ((i + 1) * 10)
    }]

    content {
      name                       = request_routing_rule.value.name
      rule_type                  = "Basic"
      priority                   = request_routing_rule.value.priority
      http_listener_name         = request_routing_rule.value.name
      backend_address_pool_name  = request_routing_rule.value.name
      backend_http_settings_name = request_routing_rule.value.name
      rewrite_rule_set_name      = local.x_fwded_proto_ruleset
    }
  }

  rewrite_rule_set {
    name = local.x_fwded_proto_ruleset

    rewrite_rule {
      name          = local.x_fwded_proto_ruleset
      rule_sequence = 100

      request_header_configuration {
        header_name  = "X-Forwarded-Proto"
        header_value = "https"
      }

      request_header_configuration {
        header_name  = "X-Forwarded-Port"
        header_value = "443"
      }

      request_header_configuration {
        header_name  = "X-Forwarded-For"
        header_value = "{var_add_x_forwarded_for_proxy}"
      }
    }
  }
}
