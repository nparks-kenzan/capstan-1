resource "random_integer" "spin_bucket" {
  min     = 1
  max     = 99999
}

resource "google_storage_bucket" "spinnaker" {
  name          = "spin-${var.ssh_user}-${var.gcp_project_id}-${random_integer.spin_bucket.result}"
  location      = "${var.bucket_location}"
  force_destroy = "true"
}