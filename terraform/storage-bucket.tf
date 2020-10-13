provider "google" {
  version = "~> 2.5.0"
  project = var.project
  region = var.region
}
module "storage-bucket" {
  source = "SweetOps/storage-bucket/google"
  version = "0.3.1"
  name = "sdv-storage-bucket-stage-1"
  location = var.region
  force_destroy = "true"
}
output storage-bucket_url {
  value = module.storage-bucket.url
}
