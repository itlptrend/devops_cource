variable project {
  description = "Project ID"
}
variable region {
  description = "Region"
  # Значение по умолчанию
  default = "europe-west1"
}

variable "gogole_bucket_names" {
  type = string
  default = "shikanov-terraform-state"
  
}
