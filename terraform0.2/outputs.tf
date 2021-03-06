
output "app_external_ip" {
  #value = google_compute_instance.app.*.name 
  #google_compute_instance.app.*.network_interface.0.access_config.0.nat_ip
  value = formatlist(
    "%s = %s", 
    (google_compute_instance.app.*.name ),
    (google_compute_instance.app.*.network_interface.0.access_config.0.nat_ip)
  )
}

output "db_external_ip" {
  #value = google_compute_instance.db.*.name 
  #google_compute_instance.db.*.network_interface.0.access_config.0.nat_ip
  value = formatlist(
    "%s = %s", 
    (google_compute_instance.db.*.name ),
    (google_compute_instance.db.*.network_interface.0.access_config.0.nat_ip)
  )
}