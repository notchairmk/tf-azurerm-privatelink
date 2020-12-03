terraform {
  required_version = ">=0.13"

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}
