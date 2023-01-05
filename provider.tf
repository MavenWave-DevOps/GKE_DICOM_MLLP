terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.44.0"
    }
  }
}
data "google_client_config" "default" {
  provider = google
}
data "google_service_account_access_token" "default" {
  provider               = google
  target_service_account = "tf-import-sa@${var.project}.iam.gserviceaccount.com"
  scopes                 = ["userinfo-email", "cloud-platform"]
  lifetime               = "1200s"
}

provider "google" {
  project         = var.project
  alias           = "impersonated"
  access_token    = data.google_service_account_access_token.default.access_token
  request_timeout = "60s"
}