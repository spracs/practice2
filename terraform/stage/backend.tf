terraform {
  backend "gcs" {
    bucket = "sdv-storage-bucket-stage-1"
    prefix = "stage"
  }
}
