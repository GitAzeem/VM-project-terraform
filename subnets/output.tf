output "DEV-id" {
  description = "id of subnet1-dev"
  value = azurerm_subnet.subnet1.id
}

output "PROD-id" {
  description = "id of aubnet 2-prod"
  value = azurerm_subnet.subnet2.id
}