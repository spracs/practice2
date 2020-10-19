resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "f1-micro"
  zone         = var.zone
  tags         = ["reddit-app"]

  boot_disk {
    initialize_params {
      image = var.app_disk_image
    }
  }

  network_interface {
    network = "default"
    access_config {
#      nat_ip = "${google_compute_address.app_ip.address}" #for terraform v12.8
      nat_ip = google_compute_address.app_ip.address
    }
  }

  metadata = {
    ssh-keys = "${var.username}:${file(var.public_key_path)}"
  }

  connection {
#    host  = "${self.network_interface.0.access_config.0.nat_ip}"  #for terraform v12.8
    host  = self.network_interface.0.access_config.0.nat_ip
    type  = "ssh"
    user  = var.username
    agent = false
    private_key = file(var.privat_key_path)
  }

  provisioner "file" {
#    source      = "${path.module}/files/puma.service"
    content      = templatefile("${path.module}/files/puma.service.tpl", {username = var.username})
    destination = "/tmp/puma.service"
  }

  provisioner "file" {
    content      = templatefile("${path.module}/files/deploy.sh.tpl", 
      {
        username = var.username,
        db_server_ip = var.db_server_ip
      })
    destination = "/tmp/deploy.sh"
  }

  provisioner "remote-exec" {
    inline = ["sh /tmp/deploy.sh"]
  }

}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}

resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}

