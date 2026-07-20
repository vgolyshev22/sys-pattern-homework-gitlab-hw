resource "yandex_lb_target_group" "web_target_group" {
  name      = "web-target-group-${var.flow}"
  region_id = "ru-central1"

  dynamic "target" {
    for_each = yandex_compute_instance.web

    content {
      subnet_id = target.value.network_interface[0].subnet_id
      address   = target.value.network_interface[0].ip_address
    }
  }
}

resource "yandex_lb_network_load_balancer" "web_balancer" {
  name = "web-network-load-balancer-${var.flow}"
  type = "external"

  listener {
    name        = "http-listener"
    port        = 80
    target_port = 80
    protocol    = "tcp"

    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.web_target_group.id

    healthcheck {
      name                = "http-healthcheck"
      interval            = 2
      timeout             = 1
      healthy_threshold   = 2
      unhealthy_threshold = 2

      http_options {
        port = 80
        path = "/"
      }
    }
  }
}
