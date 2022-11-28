# ========================================
# ========= Project Variables ============
# ========================================
/* variable "companyName" {
  description = "The name of the company - this will be used as a resource name prefix"
  type        = string
}

variable "org_id" {
  description = "Organization ID in the format 123456789012"
  type        = string
}

variable "billing_account" {
  description = "Billing Account ID in the format XXXXXX-XXXXXX-XXXXXX"
  type        = string
}
variable "folder_id" {
  description = "Folder ID for the parent folder referenced in the format of 123456789012"
  type        = string
}

variable "activate_apis" {
  description = "GCP api's to activate on project"
  type        = list(string)
}

variable "master_apis" {
  description = "Rest excess api's needed to be enabled for master respository"
  type        = list(string)
}

variable "project_labels" {
  description = "Project labels"
  type        = map(string)
}

# ====================================
# ======= Shared VPC Variables =======
# ====================================

variable "host_project_name" {
  description = "Name for the Shared VPC host project"
  type        = string
}


# ====================================
# ========= GKE Variables ============
# ====================================

variable "cluster_name" {
  description = "GKE Cluster name"
  type        = string
}

variable "project" {
  description = "GCP Project name"
  type        = string
}

variable "svpc_project" {
  type        = string
  description = "GKE GCP Project name"
  default     = null
}

# ====================================
# ========= Location Variables =======
# ====================================

variable "region" {
  description = "GCP Region"
  type        = string
}

variable "dr_region" {
  description = "Disaster recovery region to be used to extend the Apigee org"
  type        = string
}

variable "zone" {
  description = "GCP Zone"
  type        = string
}

variable "zones" {
  description = "GKE Cluster Zones"
  type        = list(any)
}

# ====================================
# ========= Network Variables ========
# ====================================

variable "network" {
  description = "Network name"
  type        = string
  default     = null
}

variable "subnetwork" {
  description = "GKE Subnet name"
  type        = string
  default     = null
}

variable "secondary_pods" {
  description = "Pods Secondary Name"
  type        = string
  default     = null
}

variable "secondary_services" {
  description = "Services Secondary Name"
  type        = string
  default     = null
}

variable "master_authorized_networks" {
  description = "Authorized network for master node pool"
  type        = list(object({ cidr_block = string, display_name = string }))
  default     = null
}

variable "master_ipv4_cidr_block" {
  description = "CIDR block to be used for the GKE master"
  type        = string
  default     = null
}

# ====================================
# ========= Maintenance Variables ====
# ====================================

variable "maintenance_recurrence" {
  description = "How often maintenance should occur"
  type        = string
}

variable "maintenance_start_time" {
  description = "When maintenance should begin"
  type        = string
}

variable "maintenance_end_time" {
  description = "When maintenance should end"
  type        = string
}

# ====================================
# ========= GKE Add-ons ==============
# ====================================

variable "istio" {
  description = "Whether or not Istio should be enabled"
  type        = bool
}

variable "cloudrun" {
  description = "Whether or not Cloudrun should be enabled"
  type        = bool
}

variable "dns_cache" {
  description = "Whether or not DNS Cache should be enabled"
  type        = bool
}

variable "config_connector" {
  description = "Whether or not config connector should be enabled"
  type        = bool
}

variable "kalm_config" {
  description = "Whether or not k8s application lifecycle manager should be enabled"
  type        = bool
}

# ====================================
# ========= Node Pool Variables ======
# ====================================

variable "node_pool_name" {
  description = "GKE Node pool name"
  type        = string
}

variable "node_pools" {
  description = "Node pool declaration"
  type        = list(map(string))
  default     = []
}

variable "node_pools_oauth_scopes" {
  description = "Node pool OAuth scopes"
  type        = map(list(string))
}

variable "node_pools_labels" {
  description = "Node pool labels"
  type        = map(map(string))
}

variable "node_pools_metadata" {
  description = "Node pool meta data"
  type        = map(map(string))
}

variable "node_pools_taints" {
  description = "Node pool taints"
  type        = map(list(object({ key = string, value = bool, effect = string })))
}

variable "node_pools_tags" {
  description = "Node pool tags"
  type        = map(list(string))
}

# ====================================
# ========= BigQuery Variables =======
# ====================================

variable "dataset_id" {
  description = "Dataset ID of bigquery dataset for GKE usage metering"
  type        = string
}

variable "dataset_name" {
  description = "Dataset name of bigquery dataset for GKE usage metering"
  type        = string
}

variable "bq_description" {
  description = "Description of BQ dataset"
  type        = string
}

variable "location" {
  description = "Location of BQ dataset"
  type        = string
}

variable "expiration" {
  description = "Time until expiration of BQ dataset"
  type        = string
}
*/