#echo ">>>>> Enable gcloud API needs"
#gcloud service-management enable iam.googleapis.com
#gcloud service-management enable cloudresourcemanager.googleapis.com
#gcloud service-management enable container.googleapis.com

resource "google_project_service" "iam_service" {
    project = "${var.gcp_project_id}"
    service = "iam.googleapis.com"

    lifecycle {
        prevent_destroy = true
    }
}

resource "google_project_service" "cloudresourcemanager_service" {
    project = "${var.gcp_project_id}"
    service = "cloudresourcemanager.googleapis.com"

    lifecycle {
        prevent_destroy = true
    }
}

resource "google_project_service" "container_service" {
    project = "${var.gcp_project_id}"
    service = "container.googleapis.com"

    lifecycle {
        prevent_destroy = true
    }
}
