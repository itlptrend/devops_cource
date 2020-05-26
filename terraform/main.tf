terraform {
  # Версия terraform
  required_version = "0.12.25"
}
provider "google" {
  # Версия провайдера
  version = "2.5.0"
  # ID проекта
  project = var.project
  region  = var.region
}

resource "google_compute_instance" "app" {
  name         = "reddit-app-${count.index}"
  machine_type = "g1-small"
  zone         = var.gcp_zone
  tags         = ["reddit-app"]
  # count        = var.app_instance_count
  count = 2
  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = var.disk_image
      # image = "reddit-base"
    }
  }
  # определение сетевого интерфейса
  network_interface {
    # сеть, к которой присоединить данный интерфейс
    network = "default"
    # использовать ephemeral IP для доступа из Интернет
    access_config {}
  }

  scheduling {
    preemptible = true
    automatic_restart = false
  }

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

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }
  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}

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