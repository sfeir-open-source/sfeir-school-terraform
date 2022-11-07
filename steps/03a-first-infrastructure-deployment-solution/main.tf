resource "google_compute_instance" "tf_instance" {
  name         = var.instance_name
  machine_type = "n1-standard-1"
  zone         = "europe-west1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
  }

  metadata = {
    serial-port-enable = 1
  }

  allow_stopping_for_update = true
}

resource "google_compute_firewall" "allow-iap" {
  name        = "allow-iap-tcp-all-${var.instance_name}" # We add instance_name to avoid name clash in GCP traning project
  description = "Allow connections from IAP"
  network     = "default"
  direction   = "INGRESS"
  priority    = 1000

  allow {
    protocol = "tcp"
  }

  lifecycle {
    create_before_destroy = true
  }

  source_ranges = ["35.235.240.0/20"]
}

