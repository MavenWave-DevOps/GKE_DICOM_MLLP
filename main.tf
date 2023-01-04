locals {
 terraform_service_account = "tf-import-sa@${var.project}.iam.gserviceaccount.com"
}
data "google_service_account_access_token" "default" {
  provider               = google.impersonation
  target_service_account = local.terraform_service_account
  scopes                 = ["userinfo-email", "cloud-platform"]
  lifetime               = "1200s"
}

provider "google" {
  project = var.project
  access_token = data.google_service_account_access_token.default.access_token
  request_timeout = "60s"
}