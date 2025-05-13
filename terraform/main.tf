# main.tf (updated with bucket + VM)
resource "google_storage_bucket" "example" {
  name     = "ncr-demo-bucket-dev"
  location = "US"
}

resource "google_compute_instance" "jenkins_vm" {
  name         = "jenkins-host"
  machine_type = "e2-medium"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network       = "default"
    access_config {}
  }

  metadata_startup_script = file("../scripts/bootstrap_jenkins.sh")
  tags = ["jenkins"]
}
