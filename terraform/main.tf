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

resource "google_container_cluster" "gke_cluster" {
  name     = "hello-cluster"
  location = var.zone

  initial_node_count = 2

  node_config {
    machine_type = "e2-medium"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}
