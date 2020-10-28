provider "google" {
  version = "~> 2.5.0"
  project = var.project
  region  = var.region
}

module "app" {
  source          = "./../modules/app"
  public_key_path = var.public_key_path
  privat_key_path = var.privat_key_path
  zone            = var.zone
  app_disk_image  = var.app_disk_image
  username        = var.username
  db_server_ip    = module.db.db_internal_ip
  deploing_app    = var.deploing_app
}

module "db" {
  source          = "./../modules/db"
  public_key_path = var.public_key_path
  privat_key_path = var.privat_key_path
  zone            = var.zone
  db_disk_image   = var.db_disk_image
  username        = var.username
  deploing_app    = var.deploing_app
}

module "vpc" {
  source = "./../modules/vpc"
  source_ranges = ["195.182.152.205/32"]
}

