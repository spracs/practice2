provider "google" {
  version = "~> 2.5.0"
  project = var.project
  region = var.region
}
module "storage-bucket-stage" {
  source = "SweetOps/storage-bucket/google"
  version = "0.3.1"
  name = "sdv-storage-bucket-stage-1"
  location = var.region
  force_destroy = "true"
}
module "storage-bucket-prod" {
  source = "SweetOps/storage-bucket/google"
  version = "0.3.1"
  name = "sdv-storage-bucket-prod-1"
  location = var.region
  force_destroy = "true"
}
output storage-bucket-stage_url {
  value = module.storage-bucket-stage.url
}
output storage-bucket-prod_url {
  value = module.storage-bucket-prod.url
}
