resource "azurerm_network_security_group" "azureNetworkSecurityGroup" {
  name                = local.security_group_name
  location            = local.location
  resource_group_name = local.resource_group_name
}


resource "azurerm_virtual_network" "vnet" {
  name                = local.vnet
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = ["172.16.0.0/20"]


  # subnet {
  #   name           = "frontend"
  #   address_prefix = "172.16.0.0/23"
  # }

  # subnet {
  #   name           = "backend"
  #   address_prefix = "172.16.2.0/23"
  # }

  # subnet {
  #   name           = "containerEnv"
  #   address_prefix = "172.16.4.0/23"
  # }


  tags = {
    environment = "dev"
  }

  depends_on = [
    azurerm_resource_group.azureResourceGroup,
    azurerm_network_security_group.azureNetworkSecurityGroup
  ]
}

resource "azurerm_subnet" "frontend" {
  name                 = "frontend"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["172.16.0.0/23"]

  depends_on = [
    azurerm_resource_group.azureResourceGroup,
  ]
}

resource "azurerm_subnet" "backend" {
  name                 = "backend"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["172.16.2.0/23"]
  # delegation {
  #   name = "cicdDelegation"
  #   service_delegation {
  #     name = "Microsoft.Web/serverFarms"
  #   }
  # }

  depends_on = [
    azurerm_resource_group.azureResourceGroup

  ]
}


resource "azurerm_subnet" "containerEnv" {
  name                 = "containerEnv"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["172.16.4.0/23"]
  # delegation {
  #   name = "cicdDelegation"
  #   service_delegation {
  #     name = "Microsoft.Web/serverFarms"
  #   }
  # }

  depends_on = [
    azurerm_resource_group.azureResourceGroup

  ]
}




#&nbsp;since these variables are re-used - a locals block makes this more maintainable
locals {
  backend_address_pool_name      = "${azurerm_virtual_network.vnet.name}-cicdbackendpool"
  frontend_port_name             = "${azurerm_virtual_network.vnet.name}-cicdfrontendpool"
  frontend_ip_configuration_name = "${azurerm_virtual_network.vnet.name}-cicdfrontendipconf"
  http_setting_name              = "${azurerm_virtual_network.vnet.name}-cicdhttpsetting"
  listener_name                  = "${azurerm_virtual_network.vnet.name}-cicdlistener"
  request_routing_rule_name      = "${azurerm_virtual_network.vnet.name}-cicdreqroutingname"
  redirect_configuration_name    = "${azurerm_virtual_network.vnet.name}-cicdredconfname"
}

