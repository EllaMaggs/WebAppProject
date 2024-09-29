terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.0.0"  # Downgrade to version 3.0.0
    }
  }

  required_version = ">= 1.0"  # Ensure you are using an appropriate version of Terraform
}

provider "azurerm" {
  features {}

  # You can set these values via environment variables instead of hardcoding
  subscription_id = "0a2e5e72-17a1-4c3d-a96d-1a1ad8524b79"
  client_id       = "45d9eb58-7a33-4b8e-9b24-453ecbd561c1"
  client_secret   = "1y48Q~OEUtTQ8Jfbf3yTVFkV4Ca2QxJCv72aLbXr"
  tenant_id       = "0a26334b-5c62-4cfb-b78c-d0147b1c7658"
}

resource "azurerm_resource_group" "rg" {
  name     = "myResourceGroup"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "asp" {
  name                = "myAppServicePlan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "app" {
  name                = "EllaMWebApp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id

  site_config {
    dotnet_framework_version  = "v4.0"
    use_32_bit_worker_process = true
  }
}
