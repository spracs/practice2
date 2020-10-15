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

variable "db_disk_image" {
  description = "Disk image for reddit db"
}

