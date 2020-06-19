    #  VIRTUALKA DB
resource "google_compute_instance" "db" {
  name         = "reddit-db-${count.index}"
  machine_type = "g1-small"
  zone         = var.zone
  tags         = ["reddit-db"]
  # count        = var.app_instance_count
  count = 1
  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = var.db_disk_image
      # image = "reddit-base"
    }
  }
  # определение сетевого интерфейса
  network_interface {
    # сеть, к которой присоединить данный интерфейс
    network = "default"

    # использовать ephemeral IP для доступа из Интернет
    access_config {}  #Вот так они сами выдадут IP.
  }

  scheduling {
    preemptible = var._preemptible
    automatic_restart = var._automatic_restart
  }

  metadata = {
    # путь до публичного ключа
    ssh-keys = <<EOT
appuser:${file(var.public_key_path)}
ashikanov:${file(var.public_key_path)} 
EOT   
  }
}


      #FIREWALL

resource "google_compute_firewall" "firewall_mongo" {
  name = "allow-mongo-default"
  # Название сети, в которой действует правило
  network = "default"
  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["27017"]
  }
  # Каким адресам разрешаем доступ
  source_ranges = ["0.0.0.0/0"]
  # Правило применимо для инстансов с перечисленными тэгами
  target_tags = ["reddit-db"]
  source_tags = ["reddit-app"]
}