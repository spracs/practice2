output "app1_external_ip" {
  value = "${google_compute_instance.reddit-app1.network_interface.0.access_config.0.nat_ip}"
}
output "app2_external_ip" {
  value = "${google_compute_instance.reddit-app2.network_interface.0.access_config.0.nat_ip}"
}

output "lb_external_ip" {
  value = "${google_compute_global_forwarding_rule.my_lb.ip_address}"
}
