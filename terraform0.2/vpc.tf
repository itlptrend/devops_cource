#Будь осторожен при terraform destroy это дефолтное правило! удалиться и не сможешь подключаться к тачкам
resource "google_compute_firewall" "_firewall_ssh" {
  name = "default-allow-ssh-terraform"
  network = "default"
  allow {
    protocol = "tcp"
    ports = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
  description = "Allow SSH from anywhere"
  # priority = 65534
}
