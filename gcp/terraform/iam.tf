resource "google_service_account" "halyard_toolsacct" {
  account_id   = "${var.service_account_name}"
  display_name = "${var.service_account_name}"
}

resource "google_project_iam_policy" "project" {
  project     = "${var.gcp_project_id}"
  policy_data = "${data.google_iam_policy.admin.policy_data}"
}

data "google_iam_policy" "admin" {
  binding {
    role = "roles/owner"

    members = [
      "serviceAccount:${google_service_account.halyard_toolsacct.email}",
    ]
  }
}
