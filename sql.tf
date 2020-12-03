resource "azurerm_mssql_server" "thisserver" {
  name                         = "thissqlserverguy2"
  resource_group_name          = azurerm_resource_group.example.name
  location                     = azurerm_resource_group.example.location
  version                      = "12.0"
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password
}

resource "azurerm_mssql_database" "thisdatabase" {
  name      = "thissqldatabaseguy"
  server_id = azurerm_mssql_server.thisserver.id
}

resource "azurerm_sql_firewall_rule" "client_ip_firewall_rule" {
  name                = "client-ip"
  resource_group_name = azurerm_resource_group.example.name
  server_name         = azurerm_mssql_server.thisserver.name
  start_ip_address    = var.client_ip
  end_ip_address      = var.client_ip
}

resource "azurerm_private_endpoint" "link" {
  name                = "sql-private-endpoint"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  subnet_id           = azurerm_subnet.private_link.id

  private_dns_zone_group {
    name                 = azurerm_private_dns_zone.example.name
    private_dns_zone_ids = [azurerm_private_dns_zone.example.id]
  }

  private_service_connection {
    name                           = "sql"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_mssql_server.thisserver.id
    subresource_names              = ["sqlServer"]
  }
}
