terraform {
  # Версия terraform
  required_version = "0.12.25"
}

# PROVIDER
provider "google" {
  # Версия провайдера
  version = "2.5.0"
  # ID проекта
  project = var.project
  region  = var.region
}

module "app" {
  source           = "../modules/app"
  public_key_path  = var.public_key_path
  zone             = var.gcp_zone
  app_disk_image   = var.app_disk_image
  private_key_path = var.private_key_path
  db_external_ip   = module.db.db_external_ip
  _preemptible = false
  _automatic_restart = true
}

module "db" {
  source          = "../modules/db"
  public_key_path = var.public_key_path
  zone            = var.gcp_zone
  db_disk_image   = var.db_disk_image
  _preemptible = false
  _automatic_restart = true
}

module "vpc" {
  source        = "../modules/vpc"
  source_ranges = ["95.217.0.75/32"]
}
