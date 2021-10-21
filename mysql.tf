data "azurerm_public_ip" "matheus-ip-db" {
  name                = azurerm_public_ip.matheus-ip.name
  resource_group_name = azurerm_resource_group.matheus.name
}

resource "time_sleep" "wait_30_seconds_db" {
  depends_on = [azurerm_linux_virtual_machine.matheus-vm]
  create_duration = "30s"
}

resource "null_resource" "upload_db" {
    provisioner "file" {
        connection {
            type = "ssh"
            admin_username = "Mliberato"
            admin_password = "Sede@2021"
            host = data.azurerm_public_ip.matheus-ip.ip_address
        }
        source = "config"
        destination = "/home/matheus"
    }

    depends_on = [ time_sleep.wait_30_seconds_db ]
}

resource "null_resource" "deploy_db" {
    triggers = {
        order = null_resource.upload_db.id
    }
    provisioner "remote-exec" {
        connection {
            type = "ssh"
            admin_username = "Mliberato"
            admin_password = "Sede@2021"
            host = data.azurerm_public_ip.matheus-ip-db.ip_address
        }
        inline = [
            "sudo apt-get update",
            "sudo apt-get install -y mysql-server-5.7",
            "sudo mysql < /home/matheus/config/user.sql",
            "sudo cp -f /home/matheus/config/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf",
            "sudo service mysql restart",
            "sleep 20",
        ]
    }
}