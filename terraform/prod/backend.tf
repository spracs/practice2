terraform {
  backend "gcs" {
    bucket = "sdv-storage-bucket-prod-1"
    prefix = "prod"
  }
}
