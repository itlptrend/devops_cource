    #  IP
resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}


    #  VIRTUALKA APP
resource "google_compute_instance" "app" {
  name         = "reddit-app-${count.index}"
  machine_type = "g1-small"
  zone         = var.zone
  tags         = ["reddit-app"]
  # count        = var.app_instance_count
  count = 1
  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = var.app_disk_image
      # image = "reddit-base"
    }
  }
  # определение сетевого интерфейса
  network_interface {
    # сеть, к которой присоединить данный интерфейс
    network = "default"

    # использовать ephemeral IP для доступа из Интернет
    # access_config {}  #Вот так они сами выдадут IP.

    #Испоьлзовать внешний айпи выданный в google_compute_address. Сначала сделает IP, потом будет создавать виртуалку.
    access_config {
      nat_ip = google_compute_address.app_ip.address
    }
  }

  # scheduling {
  #   preemptible = true
  #   automatic_restart = false
  # }

  metadata = {
    # путь до публичного ключа
    ssh-keys = <<EOT
appuser:${file(var.public_key_path)}
ashikanov:${file(var.public_key_path)} 
EOT   
  }

  connection {
    type  = "ssh"
    user  = "appuser"
    agent = false
    host  = self.network_interface.0.access_config.0.nat_ip
    # host  = google_compute_instance.app[count.index].network_interface.0.access_config.0.nat_ip Это не правильно для 0.12 версии. Надо через self.
    # путь до приватного ключа
    private_key = file(var.private_key_path)
  }

  provisioner "remote-exec" {
    inline = [
      "sudo /bin/bash -c 'echo DATABASE_URL=${element(split(" ", element(var.db_external_ip, 0)), 2)} > /etc/default/puma'",
    ]
  }

  provisioner "file" {
    source      = "${path.module}/files/puma.service"
    destination = "/tmp/puma.service"
  }
  provisioner "remote-exec" {
    script = "${path.module}/files/deploy.sh"
  }
}

      #FIREWALL

resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"
  # Название сети, в которой действует правило
  network = "default"
  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  # Каким адресам разрешаем доступ
  source_ranges = ["0.0.0.0/0"]
  # Правило применимо для инстансов с перечисленными тэгами
  target_tags = ["reddit-app"]
}