# ====================================
# ======= Enable APIs ================
# ====================================

/*resource "google_project_service" "gke-compute" {
  project = var.project
  service = "compute.googleapis.com"
}

resource "google_project_service" "gke-container" {
  project = var.project
  service = "container.googleapis.com"
}

resource "google_project_service" "service-network" {
  project = var.project
  service = "servicenetworking.googleapis.com"
}

resource "google_project_service" "service-management" {
  project = var.project
  service = "servicemanagement.googleapis.com"
}*/
