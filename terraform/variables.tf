variable "project" {
  description = "Project ID"
}

variable "region" {
  description = "Region"

  # Значение по умолчанию
  default = "europe-west1"
}

variable "zone" {
  description = "Zone"

  # Значение по умолчанию
  default = "europe-west1-b"
}

variable "public_key_path" {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}

variable "privat_key_path" {
  # Описание переменной
  description = "Path to the privat key used for ssh access"
}

variable "disk_image" {
  description = "Disk image"
}

variable "username" {
  description = "User name"

  # Значение по умолчанию
  default = "appuser"
}

variable "counter" {
  description = "Count of instances"

  # Значение по умолчанию
  default = "1"
}

