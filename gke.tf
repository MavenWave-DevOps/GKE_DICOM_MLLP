module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster"
  project_id                 = var.project
  name                       = "gke-test-1"
  region                     = "us-east4"
  zones                      = ["us-east4-a", "us-east4-b", "us-east4-c"]
  network                    = var.network
  subnetwork                 = var.subnet[1]
  ip_range_pods              = "us-east4-01-gke-01-pods"
  ip_range_services          = "us-east4-01-gke-01-services"
  http_load_balancing        = true
  network_policy             = true
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false
  enable_private_endpoint    = true
  enable_private_nodes       = true
  master_ipv4_cidr_block     = "10.0.0.0/28"
  dns_cache                  = false

  master_authorized_networks = [
    {
      cidr_block   = "10.80.0.0/16"
      display_name = "Master Authorized CIDR"
    }
  ]
  node_pools = [
    {
      name               = "default-node-pool"
      machine_type       = "e2-medium"
      node_locations     = "us-east4-a,us-east4-b"
      min_count          = 1
      max_count          = 100
      local_ssd_count    = 0
      spot               = false
      disk_size_gb       = 100
      disk_type          = "pd-standard"
      image_type         = "COS_CONTAINERD"
      enable_gcfs        = false
      enable_gvnic       = false
      auto_repair        = true
      auto_upgrade       = true
      service_account    = "tf-gke-gke-test-1-gqw2@${var.project}.iam.gserviceaccount.com"
      preemptible        = false
      initial_node_count = 3
    },
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
}