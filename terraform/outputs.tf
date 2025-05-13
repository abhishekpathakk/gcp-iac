# outputs.tf (append)
output "jenkins_vm_ip" {
  value       = google_compute_instance.jenkins_vm.network_interface[0].access_config[0].nat_ip
  description = "Public IP of the Jenkins host VM"
}

output "bucket_name" {
  value       = google_storage_bucket.example.name
  description = "Name of the demo GCS bucket"
}
output "bucket_location" {
  value       = google_storage_bucket.example.location
  description = "Location of the demo GCS bucket"
}
output "bucket_url" {
  value       = google_storage_bucket.example.url
  description = "URL of the demo GCS bucket"
}
output "jenkins_vm_name" {
  value       = google_compute_instance.jenkins_vm.name
  description = "Name of the Jenkins host VM"
}