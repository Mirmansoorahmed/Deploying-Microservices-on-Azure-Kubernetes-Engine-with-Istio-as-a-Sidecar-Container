provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "aks_rg" {
  name     = "my-aks-rg"
  location = "westeurope"
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "my-aks-cluster"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name

  dns_prefix = "my-aks-cluster-dns"

  linux_profile {
    admin_username = "azureuser"

    ssh_key {
      key_data = "your_pub_key"
    }
  }

  agent_pool_profile {
    name            = "default"
    count           = 3
    vm_size         = "Standard_D2_v2"
    os_type         = "Linux"
    vnet_subnet_id  = "/subscriptions/<subscription_id>/resourceGroups/my-rg/providers/Microsoft.Network/virtualNetworks/my-vnet/subnets/default"
  }

  service_principal {
    client_id     = "<client_id>"
    client_secret = "<client_secret>"
  }

  depends_on = [
    azurerm_resource_group.aks_rg
  ]
}

