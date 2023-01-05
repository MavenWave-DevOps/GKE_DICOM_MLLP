terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.44.0"
    }
  }
}
locals {
  terraform_service_account = "tf-import-sa@${var.project}.iam.gserviceaccount.com"
}
data "google_service_account_access_token" "default" {
  provider               = "google"
  target_service_account = local.terraform_service_account
  scopes                 = ["userinfo-email", "cloud-platform"]
  lifetime               = "1200s"
}

provider "google" {
  project         = var.project
  alias = "impersonated"
  access_token    = data.google_service_account_access_token.default.access_token
  request_timeout = "60s"
}