/*data "google_client_config" "default" {
  provider = google
}

data "google_service_account_access_token" "default" {
  provider               = google
  target_service_account = "tf-import-sa@${var.project}.iam.gserviceaccount.com"
  scopes                 = ["userinfo-email", "cloud-platform"]
  lifetime               = "300s"
}

provider "google" {
  alias        = "impersonated"
  access_token = data.google_service_account_access_token.default.access_token
}*/