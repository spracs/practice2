variable "zone" {
  description = "Zone"
}

variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}

variable "privat_key_path" {
  description = "Path to the privat key used for ssh access"
}


variable "username" {
  description = "User name"
}

#variable "counter" {
#  description = "Count of instances"
#  default = "1"
#}

variable "app_disk_image" {
  description = "Disk image for reddit app"
}

variable "db_server_ip" {
  description = "External IP reddit db server"
  default     = "127.0.0.1"
}

variable "deploing_app" {
  description = "Deploy app, yes or no"
  default = "0"
}
