resource "google_compute_instance" "default" {
  name         = format("%s-trainer-%s", var.application_name, terraform.workspace)
  machine_type = var.machine_type
  zone         = "europe-west1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network = "default"
  }

  metadata_startup_script = "echo hi > /test.txt"
}
