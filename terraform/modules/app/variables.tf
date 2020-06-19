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



#Не знаю как включать или выключать код. dynamic block не работает для provisioner
#Это переменная просто пытался.
variable "provision" {
  description = "create or destroy"
  # type string
  default = "create"
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