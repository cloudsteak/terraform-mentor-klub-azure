

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server

}

output "todo_message" {
  value = "TODO: You must create Azure DevOps Service Conection manually for the Azure Container Registry (ACR) to enable CI/CD pipeline. Or add it cloudsteak-MentorKlub-f96295a4-0752-4228-ad35-419f404433a0 service principal with ACRPush role."
}
