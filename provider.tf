terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.4.0"
    }
  }
}

provider "google" {
  project = "mygcp-project-89092"
  region  = "us-east4"
}



data "google_client_config" "default" {
  provider = google
}

data "google_service_account_access_token" "default" {
  provider               = google
  target_service_account = "terraform-exercises@mygcp-project-89092.iam.gserviceaccount.com"
  scopes                 = ["userinfo-email", "cloud-platform"]
  lifetime               = "300s"
}

provider "google" {
  alias        = "impersonated"
  access_token = data.google_service_account_access_token.default.access_token
}

data "google_client_openid_userinfo" "me" {
  provider = google.impersonated
}

output "target-email" {
  value = data.google_client_openid_userinfo.me.email
}

resource "google_compute_network" "TFexercise_network" {
  name = "tfexercise-network"
}