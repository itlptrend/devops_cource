
output "app_external_ip" {
  #value = google_compute_instance.app.*.name 
  #google_compute_instance.app.*.network_interface.0.access_config.0.nat_ip
  value = formatlist(
    "%s = %s", 
    (google_compute_instance.app.*.name ),
    (google_compute_instance.app.*.network_interface.0.access_config.0.nat_ip)
  )
}

output "lb_external_ip" {
    value = google_compute_forwarding_rule.network-load-balancer.ip_address
}