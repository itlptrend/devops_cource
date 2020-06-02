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
