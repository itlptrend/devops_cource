resource "google_compute_firewall" "firewall_ssh" {
  name = "default-allow-ssh-terraform"
  network = "default"
  allow {
    protocol = "tcp"
    ports = ["22"]
  }
  source_ranges = var.source_ranges
  description = "Allow SSH from anywhere"
  # priority = 65534
}
