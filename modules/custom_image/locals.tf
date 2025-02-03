locals {
  env_file_content = <<-EOT
    # .env file
    PORT=80
    DB_USER="adatgazda"
    DB_PASSWORD="<SQL adatgazda jelszava>"
    DB_SERVER="<SQL szerver neve>.database.windows.net"
    DB_NAME="<SQL adatbázis neve>"
    DB_PORT="1433"
  EOT
}
