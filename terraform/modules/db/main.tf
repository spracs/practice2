resource "google_compute_instance" "db" {
  name         = "reddit-db"
  machine_type = "g1-small"
  zone         = var.zone
  tags         = ["reddit-db"]

  boot_disk {
    initialize_params {
      image = var.db_disk_image
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

  metadata = {
    ssh-keys = "${var.username}:${file(var.public_key_path)}"
  }
}

resource "null_resource" "db" {
  count = var.deploing_app == "1" ? 1 : 0
  connection {
#    host  = "${self.network_interface.0.access_config.0.nat_ip}"  #for terraform v12.8
    host  = google_compute_instance.db.network_interface.0.access_config.0.nat_ip
    type  = "ssh"
    user  = var.username
    agent = false
    private_key = file(var.privat_key_path)
  }

  provisioner "remote-exec" {
    inline = ["sudo sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/' /etc/mongod.conf", 
              "sudo systemctl restart mongod"]
  }

}

resource "google_compute_firewall" "firewall_mongo" {
  name    = "allow-mongo-default"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["27017"]
  }
  target_tags = ["reddit-db"]
  source_tags = ["reddit-app"]
}

