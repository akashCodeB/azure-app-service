# App service creates VM when scaling and we don't want that
# resource "azurerm_service_plan" "azureAppServicePlan" {
#   name                = "example"
#   resource_group_name = local.resource_group_name
#   location            = local.location
#   os_type             = "Linux"
#   sku_name            = "B1"

#   depends_on = [
#     azurerm_resource_group.azureResourceGroup
#   ]
# }

# resource "azurerm_linux_web_app" "azureLinuxWebApp" {
#   name                = local.web_app_name
#   resource_group_name = local.resource_group_name
#   location            = local.location
#   service_plan_id     = azurerm_service_plan.azureAppServicePlan.id



#   site_config {}


#   depends_on = [
#     azurerm_resource_group.azureResourceGroup,
#     azurerm_service_plan.azureAppServicePlan
#   ]
# }

# resource "azurerm_app_service_virtual_network_swift_connection" "backendSubnet" {
#   app_service_id = azurerm_linux_web_app.azureLinuxWebApp.id
#   subnet_id      = azurerm_subnet.backend.id
#   depends_on = [
#     azurerm_subnet.backend
#   ]
# }


# # resource "azurerm_app_service_source_control" "azureServiceSourceControl" {
# #   app_id = azurerm_service_plan.azureAppServicePlan.id
# #   depends_on = [
# #     azurerm_linux_web_app.azureLinuxWebApp
# #   ]

# # }
