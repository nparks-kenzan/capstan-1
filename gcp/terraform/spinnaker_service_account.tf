resource "google_service_account" "spinnaker" {
  account_id   = "${var.spinnaker_service_account}"
  display_name = "${var.spinnaker_service_account}"
}

resource "google_service_account_iam_binding" "spinnaker_storage_admin" {
  service_account_id = "${google_service_account.spinnaker.email}"
  role               = "roles/storage.admin"
  members = [
    "serviceAccount:${google_service_account.spinnaker.email}"
  ]
}

resource "google_service_account_iam_binding" "spinnaker_monitoring_viewer" {
  service_account_id = "${google_service_account.spinnaker.email}"
  role               = "roles/monitoring.viewer"
  members = [
    "serviceAccount:${google_service_account.spinnaker.email}"
  ]
}

resource "google_service_account_iam_binding" "spinnaker_metric_writer" {
  service_account_id = "${google_service_account.spinnaker.email}"
  role               = "roles/monitoring.metricWriter"
  members = [
    "serviceAccount:${google_service_account.spinnaker.email}"
  ]
}

resource "google_service_account_iam_binding" "spinnaker_compute_viewer" {
  service_account_id = "${google_service_account.spinnaker.email}"
  role               = "roles/compute.viewer"
  members = [
    "serviceAccount:${google_service_account.spinnaker.email}"
  ]
}