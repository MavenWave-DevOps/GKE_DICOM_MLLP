module "shared-vpc-host-project" {
  source                         = "git::ssh://git@gitlab.com/akumin/google-cloud-platform/akumin-gcp-project-factory.git"
  org_id                         = var.org_id
  random_project_id              = false
  name                           = var.project_name
  project_id                     = var.project_id
  enable_shared_vpc_host_project = true
  billing_account                = var.billing_account
  folder_id                      = var.folder_id
  create_project_sa              = false
  labels                         = var.labels
  activate_apis                  = var.activate_apis
}
