variable "project" {
  description = "Project ID"
}

variable "region" {
  description = "Region"
  default     = "europe-west1"
}

variable "zone" {
  description = "Zone"
  default     = "europe-west1-b"
}

variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}

variable "privat_key_path" {
  description = "Path to the privat key used for ssh access"
}

#variable "disk_image" {
#  description = "Disk image"
#}

variable "username" {
  description = "User name"
  default     = "appuser"
}

variable "app_disk_image" {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable "db_disk_image" {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}

variable "db_server_ip" {
  description = "External IP reddit db server"
  default = "127.0.0.1"
}

variable "deploing_app" {
  description = "Deploy app, yes or no"
}
