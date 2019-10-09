variable "application_name" {}
variable "machine_type" {}
variable "gcp_project" {}

resource "google_compute_instance" "default" {
  project      = var.gcp_project
  name         = var.application_name
  machine_type = var.machine_type
  zone         = "europe-west1-b"


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }


  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}
