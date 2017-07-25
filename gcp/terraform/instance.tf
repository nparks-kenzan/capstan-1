


resource "google_compute_instance" "halyardtunnel" {
	name = "${var.halyard_machine_name}"
	machine_type = "${var.halyard_machine_type}"
	zone = "${var.region}-${var.zone}"

	tags = ["halyard","${var.created_by}","ssh-tunnel"]

	disk {
		image = "${var.ubuntu_image}"
	}

	  service_account {
    scopes = ["userinfo-email", "cloud-platform"]
    email="${google_service_account.halyard_toolsacct.email}"
  }

	connection {
    user = "${var.ssh_user}"
  	private_key = "${file(var.ssh_private_key_location)}"
  	agent = false
  }


    network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

    provisioner "file" {
  	source = "../scripts/"
    destination = "/home/${var.ssh_user}"
  }


    provisioner "remote-exec" {
    inline = [
  		"chmod +x /home/${var.ssh_user}/*.sh",
  		"/home/${var.ssh_user}/instance_execute.sh",
      "/home/${var.ssh_user}/create_GKE.sh",
      "/home/${var.ssh_user}/create_jenkins.sh",
      "/home/${var.ssh_user}/halyard_createSpinnaker.sh"
  	]
  }
}
