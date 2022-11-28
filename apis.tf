# ====================================
# ======= Enable APIs ================
# ====================================

resource "google_project_service" "gke-compute" {
  project = var.project_name
  service = "compute.googleapis.com"
}

resource "google_project_service" "gke-container" {
  project = var.project_name
  service = "container.googleapis.com"
}

resource "google_project_service" "service-network" {
  project = var.project_name
  service = "servicenetworking.googleapis.com"
}

resource "google_project_service" "service-management" {
  project = var.project_name
  service = "servicemanagement.googleapis.com"
}
