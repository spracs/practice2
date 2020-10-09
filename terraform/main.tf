provider "google" {
  # Версия провайдера
  version = "~> 2.5.0"

  # ID проекта
  project = var.project
  region  = var.region
}

resource "google_compute_instance" "reddit-app" {
  count        = var.counter
  name         = "reddit-app${count.index}"
  machine_type = "f1-micro"
  zone         = var.zone
  tags         = ["reddit-app"]

  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = var.disk_image
    }
  }

  # определение сетевого интерфейса
  network_interface {
    # сеть, к которой присоединить данный интерфейс
    network = "default"

    # использовать ephemeral IP для доступа из Интернет
    access_config {
    }
  }

  metadata = {
    ssh-keys = "${var.username}:${file(var.public_key_path)}appuser2:${file(var.public_key_path)}appuser3:${file(var.public_key_path)}"
  }

  connection {
    host  = "${self.network_interface.0.access_config.0.nat_ip}"
    type  = "ssh"
    user  = var.username
    agent = false

    # путь до приватного ключа
    private_key = file(var.privat_key_path)
  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}

resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"

  # Название сети, в которой действует правило
  network = "default"

  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  # Каким адресам разрешаем доступ
  source_ranges = ["0.0.0.0/0"]

  # Правило применимо для инстансов с перечисленными тэгами
  target_tags = ["reddit-app"]
}

