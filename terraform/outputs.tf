output "app_external_ip" {
  value = google_compute_instance.reddit-app.*.network_interface.0.access_config.0.nat_ip
}

output "lb_external_ip" {
  value = google_compute_global_forwarding_rule.my_lb.ip_address
}

