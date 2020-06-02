variable public_key_path {
  description = "Path to the public key used to connect to instance"
}
variable zone {
  description = "Zone"
}

variable app_disk_image {
  description = "Disk image for reddit db"
  default = "reddit-db"
}

variable app_instance_count {
  default = 1
}

variable private_key_path {
  # Описание переменной
  description = "Path to the privete key used for ssh access"
}

variable "db_external_ip" {
  description = "db ip"
  type = list
}
