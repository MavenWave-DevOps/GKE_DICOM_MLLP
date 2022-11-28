# ====================================
# ======= GKE Cluster ================
# ====================================

locals {
  master_authorized_networks = concat([
    for i in data.terraform_remote_state.hostVpc[0].outputs.subnets : {
      cidr_block   = i.ip_cidr_range,
      display_name = i.name,
    }
    ],
    [
      {
        cidr_block   = "0.0.0.0/0",
        display_name = "any"
      }
    ]
  )

  default_dr_pool = [
    {
      name        = "default",
      node_count  = 0,
      autoscaling = false
    }
  ]
}

resource "google_service_account" "service_account" {
  account_id   = "${var.companyName}-production-gke"
  display_name = "${var.companyName}-production-gke"
  description  = "${var.companyName} GKE Service Account - production environment"
  project      = module.shared-svcs-gke-project.project_id
}

module "gke" {
  source = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster"

  project_id = module.shared-svcs-gke-project.project_id
  name       = var.cluster_name

  # Network specs
  region                    = var.region
  zones                     = var.zones
  network                   = data.terraform_remote_state.hostVpc[0].outputs.network_name
  network_project_id        = data.terraform_remote_state.hostVpc[0].outputs.svpc_host_project_id
  subnetwork                = data.terraform_remote_state.hostVpc[0].outputs.subnets["us-east4/${var.companyName}-gke"].name
  ip_range_pods             = data.terraform_remote_state.hostVpc[0].outputs.subnets["us-east4/${var.companyName}-gke"].secondary_ip_range[1].range_name
  ip_range_services         = data.terraform_remote_state.hostVpc[0].outputs.subnets["us-east4/${var.companyName}-gke"].secondary_ip_range[0].range_name
  default_max_pods_per_node = var.default_max_pods_per_node
  # General cluster config
  http_load_balancing        = true
  horizontal_pod_autoscaling = true
  network_policy             = true
  create_service_account     = true
  remove_default_node_pool   = true

  # Private cluster config
  enable_private_nodes    = true
  enable_private_endpoint = false
  //master_ipv4_cidr_block     = cidrsubnet(data.terraform_remote_state.hostVpc[0].outputs.production_host_subnet_attrs["us-east4/${var.companyName}-svpc-production-gke-primary"].ip_cidr_range, 4, 0)
  master_ipv4_cidr_block     = var.master_ipv4_cidr_block
  master_authorized_networks = local.master_authorized_networks

  # Cluster add ons
  istio                            = var.istio
  cloudrun                         = var.cloudrun
  dns_cache                        = var.dns_cache
  config_connector                 = var.config_connector
  kalm_config                      = var.kalm_config
  resource_usage_export_dataset_id = var.dataset_id

  # Maintenance Scheduling
  maintenance_recurrence = var.maintenance_recurrence
  maintenance_start_time = var.maintenance_start_time
  maintenance_end_time   = var.maintenance_end_time


  # Node pools config
  node_pools              = var.node_pools
  node_pools_oauth_scopes = var.node_pools_oauth_scopes
  node_pools_labels       = var.node_pools_labels
  node_pools_metadata     = var.node_pools_metadata
  node_pools_taints       = var.node_pools_taints
  node_pools_tags         = var.node_pools_tags
  enable_shielded_nodes   = true
  depends_on = [
    module.shared-svcs-gke-project
  ]

}

##########Roles Assigned To Service Account Of GKE###############
#################################################################
#################################################################

resource "google_project_iam_member" "gke_role" {
  for_each = toset(var.gke_role)
  project  = module.shared-svcs-gke-project.project_id
  role     = each.value
  member   = "serviceAccount:${module.gke.service_account}"
}

//module "gke-disaster-recovery" {
//  source = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster"
//
//  project_id = module.production-business-function-project.project_id
//  name       = "${var.cluster_name}-dr"
//
//  # Network specs
//  region             = var.dr_region
//  zones              = var.dr_zones
//  network            = data.terraform_remote_state.hostVpc[0].outputs.production_network.network.name
//  network_project_id = data.terraform_remote_state.hostVpc[0].outputs.svpc_host_project_id
//  subnetwork         = data.terraform_remote_state.hostVpc[0].outputs.production_host_subnet_attrs["us-central1/${var.companyName}-svpc-production-gke-dr"].name
//  ip_range_pods      = data.terraform_remote_state.hostVpc[0].outputs.production_host_subnet_attrs["us-central1/${var.companyName}-svpc-production-gke-dr"].secondary_ip_range[1].range_name
//  ip_range_services  = data.terraform_remote_state.hostVpc[0].outputs.production_host_subnet_attrs["us-central1/${var.companyName}-svpc-production-gke-dr"].secondary_ip_range[0].range_name
//
//  # General cluster config
//  http_load_balancing        = true
//  horizontal_pod_autoscaling = true
//  network_policy             = true
//  create_service_account     = var.enable_dr_pool ? true : false
//  remove_default_node_pool   = true
//
//  # Private cluster config
//  enable_private_nodes    = true
//  enable_private_endpoint = true
//  master_ipv4_cidr_block     = var.dr_master_ipv4_cidr_block
//  master_authorized_networks = local.master_authorized_networks
//
//  # Cluster add ons
//  istio                            = var.istio
//  cloudrun                         = var.cloudrun
//  dns_cache                        = var.dns_cache
//  config_connector                 = var.config_connector
//  kalm_config                      = var.kalm_config
//  resource_usage_export_dataset_id = var.dataset_id
//
//  # Maintenance Scheduling
//  maintenance_recurrence = var.maintenance_recurrence
//  maintenance_start_time = var.maintenance_start_time
//  maintenance_end_time   = var.maintenance_end_time
//
//
//  # Node pools config
//  node_pools              = var.enable_dr_pool ? var.node_pools : local.default_dr_pool
//  node_pools_oauth_scopes = var.enable_dr_pool ? var.node_pools_oauth_scopes : {}
//  node_pools_labels       = var.enable_dr_pool ? var.node_pools_labels : {}
//  node_pools_metadata     = var.enable_dr_pool ? var.node_pools_metadata : {}
//  node_pools_taints       = var.enable_dr_pool ? var.node_pools_taints : {}
//  node_pools_tags         = var.enable_dr_pool ? var.node_pools_tags : {}
//  enable_shielded_nodes   = true
//  depends_on = [
//    module.production-business-function-project
//  ]
//
//}

# ====================================
# ======= Usage Metering =============
# ====================================

module "bigquery" {
  source  = "terraform-google-modules/bigquery/google"
  version = "~> 4.3"

  dataset_id                  = var.dataset_id
  dataset_name                = var.dataset_name
  description                 = var.bq_description
  project_id                  = module.shared-svcs-gke-project.project_id
  location                    = var.location
  default_table_expiration_ms = var.expiration

}
