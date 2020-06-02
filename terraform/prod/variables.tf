variable project {
  #  default = "shikanov-project"
  description = "Project ID"
}
variable region {
  description = "Region"
  # Значение по умолчанию
  default = "europe-west1"
}
variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}

variable private_key_path {
  # Описание переменной
  description = "Path to the privete key used for ssh access"
}

variable gcp_zone {
  default = "europe-west1-b"
}

variable disk_image {
  description = "Disk image"
}

variable app_instance_count {
  default = 1
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db"
}