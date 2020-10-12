resource "google_compute_instance_group" "redditapps" {
  name        = "terraform-redditapps-group"
  description = "Terraform test instance group"
  instances   = google_compute_instance.reddit-app.*.self_link

  named_port {
    name = "http"
    port = "9292"
  }

  zone = var.zone
}

resource "google_compute_health_check" "default" {
  name = "website-hc"

  http_health_check {
    port = "9292"
  }
}

resource "google_compute_backend_service" "default" {
  backend {
    group = google_compute_instance_group.redditapps.self_link
  }

  name        = "website-backend"
  protocol    = "HTTP"
  timeout_sec = 10

  health_checks = [google_compute_health_check.default.self_link]
}

resource "google_compute_global_forwarding_rule" "my_lb" {
  name        = "website-forwarding-rule"
  ip_protocol = "TCP"
  port_range  = "80"
  target      = google_compute_target_http_proxy.default.self_link
}

resource "google_compute_target_http_proxy" "default" {
  name = "test-proxy"

  url_map = google_compute_url_map.default.self_link
}

resource "google_compute_url_map" "default" {
  name            = "website-map"
  default_service = google_compute_backend_service.default.self_link
}

