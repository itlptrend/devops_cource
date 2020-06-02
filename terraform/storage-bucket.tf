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
# https://registry.terraform.io/browse/modules?provider=google
# https://registry.terraform.io/modules/SweetOps/storage-bucket/google/0.3.1
module "storage-bucket" {
  source = "SweetOps/storage-bucket/google"
  version = "0.3.1"
  # Имена поменяйте на другие
  name = var.gogole_bucket_names
  location = var.region
  storage_class = "STANDARD"
}

output storage-bucket_url {
  value = module.storage-bucket.url
}