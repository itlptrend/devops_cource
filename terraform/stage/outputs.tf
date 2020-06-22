
output "app_external_ip" {
  value = "${module.app.app_external_ip}"
}

output "db_external_ip" {
  value = "${module.db.db_external_ip}"
}


### The Ansible inventory file
resource "local_file" "AnsibleInventory" {
 content = templatefile("ansible-inventory.tmpl",
 {
  server_names = concat(module.app.server_names,module.db.server_names),
  server_ips = concat(module.app.server_ips,module.db.server_ips),
  server_group_app = module.app.server_names,
  server_group_db = module.db.server_names,
 }
 )
 filename = "ansible-inventory.ini"
}