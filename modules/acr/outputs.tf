

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server

}

output "todo_message" {
  value = "TODO: You must create Azure DevOps Service Conection manually for the Azure Container Registry (ACR) to enable CI/CD pipeline. Or add the right service principal to it with ACRPush role."
}
