# https://github.com/hmcts/terraform-module-applicationgateway

Terraform module to create Azure Application Gateway resource.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| common\_tags | Common Tags | `map(string)` | n/a | yes |
| destinations | List of IP addresses to direct traffic to | `list(string)` | n/a | yes |
| env | environment, will be used in resource names and for looking up the vnet details | `any` | n/a | yes |
| frontends | n/a | `list(any)` | n/a | yes |
| location | location to deploy resources to | `any` | n/a | yes |
| log\_analytics\_workspace\_id | Enter log analytics workspace id | `string` | n/a | yes |
| max\_capacity | Maximum capacity for autoscaling | `number` | `10` | no |
| min\_capacity | Minimum capacity for autoscaling | `number` | `2` | no |
| oms\_env | Name of the enviornment for log analytics workspace | `any` | n/a | yes |
| private\_ip\_address | IP address to allocate staticly to app gateway, must be in the subnet for the env | `any` | n/a | yes |
| project | Name of the project | `string` | n/a | yes |
| subscription | subscription, will be used for looking up the keyvault details | `any` | n/a | yes |
| vnet\_name | Name of the Virtual Network | `string` | n/a | yes |
| vnet\_rg | Name of the virtual Network resource group | `string` | n/a | yes |

## Outputs

No output.

