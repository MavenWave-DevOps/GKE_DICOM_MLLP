// Fill in the required fields with your specific info as necessary

module "shared-services" {



companyName     = "Infra Mavenwave"
org_id          = "487033049345"
billing_account = "0105E1-61A6DE-D85D10"
folder_id       = "995591527023"
activate_apis = [
  "compute.googleapis.com",
  "container.googleapis.com",
]

project_labels = {
  env = "sandbox"
}

master_apis = [
  "apigee.googleapis.com",
  "artifactregistry.googleapis.com",
  "bigquery.googleapis.com",
  "bigquerystorage.googleapis.com",
  "cloudapis.googleapis.com",
  "clouddebugger.googleapis.com",
  "cloudkms.googleapis.com",
  "cloudtrace.googleapis.com",
  "datastore.googleapis.com",
  "healthcare.googleapis.com",
  "containerregistry.googleapis.com",
  "iam.googleapis.com",
  "iamcredentials.googleapis.com",
  "logging.googleapis.com",
  "monitoring.googleapis.com",
  "notebooks.googleapis.com",
  "oslogin.googleapis.com",
  "pubsub.googleapis.com",
  "servicemanagement.googleapis.com",
  "servicenetworking.googleapis.com",
  "serviceusage.googleapis.com",
  "sql-component.googleapis.com",
  "storage-api.googleapis.com",
  "storage-component.googleapis.com",
  "storage.googleapis.com",
  "firewallinsights.googleapis.com",
  "dataflow.googleapis.com",
]

//GKE cluster name
cluster_name = "shared-services-cluster"
project      = "531303019713"
svpc_project = "1091854886577"

//GKE region
region = "us-east4"
zone   = "us-east4-b"
zones = [
  "us-east4-b",
  "us-east4-c",
  "us-east4-a",
]
master_ipv4_cidr_block = "10.0.0.32/28"
# ====================================
# ========= Maintenance Variables ====
# ====================================
maintenance_recurrence = "FREQ=DAILY"
maintenance_start_time = "2020-11-10T22:00:00Z"
maintenance_end_time   = "2020-11-12T02:00:00Z"


# ====================================
# ========= GKE Add-ons ==============
# ====================================
istio            = false
cloudrun         = false
dns_cache        = false
config_connector = false
kalm_config      = false


# ====================================
# ========= Node Pool Variables ======
# ====================================
node_pool_name = "shared-services-sandbox-node-pool"

node_pools = [
  {
    name                        = "pool1"
    machine_type                = "e2-small"
    node_locations              = "us-east4-b,us-east4-a"
    min_count                   = 1
    max_count                   = 3
    local_ssd_count             = 0
    disk_size_gb                = 50
    disk_type                   = "pd-standard"
    image_type                  = "COS_CONTAINERD"
    auto_repair                 = true
    auto_upgrade                = true
    preemptible                 = false
    initial_node_count          = 1
    enable_secure_boot          = true
    enable_integrity_monitoring = true
  }
]

node_pools_oauth_scopes = {

  pool1 = [
    "https://www.googleapis.com/auth/compute",
    "https://www.googleapis.com/auth/devstorage.read_only",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/devstorage.read_only",
    "monitoring"
  ]
}

node_pools_labels = {
  all = {}
}

node_pools_metadata = {
  all = {}

  pool1 = {
    node-pool-metadata-custom-value = "inframw-sandbox-nodepool"
  }
}

node_pools_taints = {
  all = []
}

# Add tags for firewall rules
node_pools_tags = {
  all = []
}

terraform_remote_state_bucket = "sandbox-devops-terraform-state"
host_vpc_output_path          = "host-svpc"

dataset_id     = "Sandbox"
dataset_name   = "SandboxDS"
bq_description = ""
location       = "US"
expiration     = 3600000

iap_support_email     = ""
iap_application_title = ""

// GKE Roles
gke_role = [
  "roles/pubsub.subscriber",
  "roles/healthcare.hl7V2Ingest",
  "roles/healthcare.dicomEditor",
  "roles/logging.logWriter",
  "roles/monitoring.metricWriter",
  "roles/monitoring.viewer",
  "roles/stackdriver.resourceMetadata.writer"
]

}