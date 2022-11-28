variable "project_id" {
  description = "The Project ID to create the VPC/Networks in"
  type        = string
}

variable "region" {
  description = "The default region for the subnetworks and other creations."
  type        = string
}

variable "dr_region" {
  description = "The region to be used for Disaster recovery components"
  type        = string
}

variable "interconnected_region" {
  description = "The region to be used for interconnect and router."
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC to be created."
  type        = string
}

variable "subnetworks" {
  description = "The subnetworks including their name, ip, region, and description. You can also override the flow logs or private access."
  type        = list(map(string))
  default     = []
}

variable "secondary_ranges" {
  description = "These are the secondary ranges for the subnetworks"
  type = map(list(object({
    range_name    = string,
    ip_cidr_range = string
  })))
  default = {}
}

variable "default_subnet_flow_logs" {
  default     = "true"
  description = "The default value for subnet_flow_logs within each subnet"
  type        = string
}

variable "default_subnet_private_access" {
  default     = "true"
  description = "The default value for subnet_private_access within each subnet"
  type        = string
}

variable "routes" {
  default     = []
  description = "List of routes being created in this VPC"
  type        = list(map(string))
}

variable "peering_networks" {
  type        = map(map(string))
  description = "map of peering project name and network name"
  default     = {}
}

variable "nat" {
  type        = bool
  description = "Whether to NAT out of each regional subnetwork"
  default     = false
}

variable "asn" {
  type        = string
  description = "ASN for use with the Cloud router"
  default     = ""
}

variable "vpc_firewall_rules" {
  description = "List of firewall rule definitions for the specific VPC"
  default     = {}
  type = map(object({
    description          = string
    direction            = string
    action               = string # (allow|deny)
    ranges               = list(string)
    sources              = list(string)
    targets              = list(string)
    use_service_accounts = bool
    rules = list(object({
      protocol = string
      ports    = list(string)
    }))
    extra_attributes = map(string)
  }))
}

variable "ingress_firewall_rules" {
  description = "List of firewall rule definitions for the IAP, https and ide"
  default     = {}
  type = map(object({
    description          = string
    direction            = string
    action               = string # (allow|deny)
    ranges               = list(string)
    sources              = list(string)
    targets              = list(string)
    use_service_accounts = bool
    rules = list(object({
      protocol = string
      ports    = list(string)
    }))
    extra_attributes = map(string)
  }))
}

variable "project_name" {
  type        = string
  description = "The name of the project - required for child module"
}

variable "org_id" {
  type        = string
  description = "The organization ID for GCP - requried for child module"
}

variable "billing_account" {
  type        = string
  description = "The billing account ID for GCP - requried for child module"
}

variable "folder_id" {
  type        = string
  description = "The folder ID for GCP - requried for child module"
}

variable "labels" {
  type        = map(string)
  description = "GCP labels"
  default     = {}
}

variable "activate_apis" {
  type        = list(string)
  description = "The apis to activate in GCP"
  default     = []
}



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