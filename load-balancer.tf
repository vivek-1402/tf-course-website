resource "google_compute_backend_service" "backend_service" {
  name        = "${var.project}-${terraform.workspace}-backend-service"
  protocol    = "HTTP"
  timeout_sec = 10

  dynamic "backend" {
    for_each = var.regions
    content {
      group           = google_compute_region_instance_group_manager.instance_group[backend.value].instance_group
      balancing_mode  = "UTILIZATION"
      capacity_scaler = 1.0
    }
  }

  health_checks = [google_compute_http_health_check.health_check.id]
}

resource "google_compute_http_health_check" "health_check" {
  name         = "${var.project}-${terraform.workspace}-health-check"
  request_path = "/"

  timeout_sec        = 1
  check_interval_sec = 1
}

resource "google_compute_url_map" "url_map" {
  name            = "${var.project}-${terraform.workspace}-load-balancer"
  default_service = google_compute_backend_service.backend_service.id
}

resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "test-proxy-${terraform.workspace}"
  url_map = google_compute_url_map.url_map.id
}

resource "google_compute_global_forwarding_rule" "forwarding-rule" {
  name       = "global-rule-${terraform.workspace}"
  target     = google_compute_target_http_proxy.http_proxy.id
  port_range = "80"
}
