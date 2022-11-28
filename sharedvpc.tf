module "project-factory_example_shared_vpc" {
  source               = "terraform-google-modules/project-factory/google//examples/shared_vpc"
  version              = "14.1.0"
  org_id               = "487033049345"
  billing_account      = "0105E1-61A6DE-D85D10"
  folder_id            = "995591527023"
  host_project_name    = "rwl-gke-hostsvpc"
  network_name         = "gke-svpc"
  service_project_name = "rwl-gke-service-project"

}