


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


	provisioner "remote-exec" {
    inline = [
  		"mkdir -p /tmp/terraform/"
    ]
  }


    provisioner "file" {
  	source = "../scripts/"
    destination = "/tmp/terraform"
  }


    provisioner "remote-exec" {
    inline = [
  		"chmod +x /tmp/terraform/*.sh",
  		"/tmp/terraform/test.sh"
  	]
  }
}
