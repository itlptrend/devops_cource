output "db_external_ip" {
  #value = google_compute_instance.db.*.name 
  #google_compute_instance.db.*.network_interface.0.access_config.0.nat_ip
  value = formatlist(
    "%s = %s", 
    (google_compute_instance.db.*.name ),
    (google_compute_instance.db.*.network_interface.0.access_config.0.nat_ip)
  )
}


output "server_names" {
  value = google_compute_instance.db.*.name
}

output "server_ips" {
  value = google_compute_instance.db.*.network_interface.0.access_config.0.nat_ip
}