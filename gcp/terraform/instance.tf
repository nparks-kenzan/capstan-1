resource "google_compute_instance" "halyardtunnel" {
  name         = "${var.halyard_machine_name}"
  machine_type = "${var.halyard_machine_type}"
  zone         = "${var.region}-${var.zone}"

  depends_on = [
    #"google_project_service.iam_service",
    #"google_project_service.cloudresourcemanager_service",
    #"google_project_service.container_service",
    #"google_compute_ssl_certificate.genericwildcard",
    "google_project_iam_policy.project",

    "google_service_account.spinnaker",
    "google_service_account_iam_binding.spinnaker_storage_admin",
    "google_service_account_iam_binding.spinnaker_monitoring_viewer",
    "google_service_account_iam_binding.spinnaker_metric_writer",
    "google_service_account_iam_binding.spinnaker_compute_viewer",

    "google_container_cluster.primary",
  ]

  tags = ["halyard", "${var.created_by}", "ssh-tunnel"]

  boot_disk {
    initialize_params {
      image = "${var.ubuntu_image}"
    }
  }

  service_account {
    scopes = ["userinfo-email", "cloud-platform"]
    email  = "${google_service_account.halyard_toolsacct.email}"
  }

  connection {
    user        = "${var.ssh_user}"
    private_key = "${file(var.ssh_private_key_location)}"
    agent       = false
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  provisioner "file" {
    source      = "../scripts/"
    destination = "/home/${var.ssh_user}"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/${var.ssh_user}/*.sh",
      "/home/${var.ssh_user}/instance_execute.sh",
      "/home/${var.ssh_user}/create_GKE.sh ${var.gcp_project_id} ${var.gke_cluster_name} ${var.gke_primary_zone}",
      "/home/${var.ssh_user}/helm_packages.sh",
      "/home/${var.ssh_user}/halyard_createSpinnaker.sh ${var.gcp_project_id} ${var.gke_cluster_name} ${var.gke_primary_zone} ${google_service_account.spinnaker.email}",

      #"/home/${var.ssh_user}/enableOauth2.sh ${var.gcp_project_id} ${var.ux_fqdn} ${var.api_fqdn} ${var.oauth2_clientid} ${var.oauth2_secret} ${var.gsuite}",
      "/home/${var.ssh_user}/deploy_Spinnaker.sh",

      #"/home/${var.ssh_user}/enablednstls.sh ${var.gcp_project_id} ${var.ux_fqdn} ${var.api_fqdn} ${var.gcp_dns_zonename}",
      "/home/${var.ssh_user}/noop.sh",
    ]
  }
}
