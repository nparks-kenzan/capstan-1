resource "google_service_account" "halyard_toolsacct" {
  account_id   = "${var.service_account_name}"
  display_name = "${var.service_account_name}"
}

resource "google_service_account" "spinnaker" {
  account_id   = "${var.spinnaker_service_account_name}"
  display_name = "${var.spinnaker_service_account_name}"
}


resource "google_project_iam_member" "spin_pubsub_iammember" {
  project = "${var.gcp_project_id}"
  role    = "roles/pubsub.subscriber"
  member  = "serviceAccount:${google_service_account.spinnaker.email}"
}

resource "google_project_iam_member" "spin_computeview_iammember" {
  project = "${var.gcp_project_id}"
  role    = "roles/compute.viewer"
  member  = "serviceAccount:${google_service_account.spinnaker.email}"
}

resource "google_project_iam_member" "spin_metricwrite_iammember" {
  project = "${var.gcp_project_id}"
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.spinnaker.email}"
}

resource "google_project_iam_member" "spin_monitorview_iammember" {
  project = "${var.gcp_project_id}"
  role    = "roles/monitoring.viewer"
  member  = "serviceAccount:${google_service_account.spinnaker.email}"
}

resource "google_project_iam_member" "spin_storageadmin_iammember" {
  project = "${var.gcp_project_id}"
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.spinnaker.email}"
}

resource "google_project_iam_member" "tools_owneradmin_iammember" {
  project = "${var.gcp_project_id}"
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.halyard_toolsacct.email}"
}