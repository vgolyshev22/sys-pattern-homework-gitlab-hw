data "yandex_compute_image" "ubuntu_2204_lts" {
  family = "ubuntu-2204-lts"
}

locals {
  zones = [
    "ru-central1-a",
    "ru-central1-b"
  ]

  subnet_ids = [
    yandex_vpc_subnet.develop_a.id,
    yandex_vpc_subnet.develop_b.id
  ]
}

resource "yandex_compute_instance" "web" {
  count = 2

  name        = "web-${count.index + 1}"
  hostname    = "web-${count.index + 1}"
  platform_id = "standard-v3"
  zone        = local.zones[count.index]

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_2204_lts.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  network_interface {
    subnet_id = local.subnet_ids[count.index]
    nat       = false

    security_group_ids = [
      yandex_vpc_security_group.web_sg.id
    ]
  }

  metadata = {
    user-data          = file("${path.module}/cloud-init.yml")
    serial-port-enable = "1"
  }

  scheduling_policy {
    preemptible = true
  }
}
