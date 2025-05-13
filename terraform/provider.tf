provider "google" {
  credentials = file(var.credentials_path)
  project     = var.project
  region      = var.region
}

# Define variables with validation
variable "credentials_path" {
  description = "Path to the Google Cloud credentials JSON file"
  type        = string
  validation {
    condition     = can(file(var.credentials_path))
    error_message = "The credentials file path is invalid or the file does not exist."
  }
}

variable "project" {
  description = "Google Cloud project ID"
  type        = string
}

variable "region" {
  description = "Google Cloud region"
  type        = string
}
