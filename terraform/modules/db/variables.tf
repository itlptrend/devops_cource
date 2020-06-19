variable public_key_path {
  description = "Path to the public key used to connect to instance"
}
variable zone {
  description = "Zone"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default = "reddit-db"
}

variable app_instance_count {
  default = 1
}

variable "_preemptible" {
  description = ""
  type = bool
  default = false
}

variable "_automatic_restart" {
  description = ""
  type = bool
  default = true
}