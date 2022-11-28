locals {
  project_name = "shared-service-hostvpc"
  project_id   = local.project_name
}
module "vpc-hostvpc" {
  source = "../"

  project_id            = local.project_id
  project_name          = local.project_name
  region                = "us-east4"
  dr_region             = "us-central1"
  interconnected_region = "us-central1"
  vpc_name              = "rwl-sb-use4-hostvpc"
  org_id                = "487033049345"
  billing_account       = "0105E1-61A6DE-D85D10"
  //Use terraform remote state lookup
  folder_id = "995591527023"
  asn       = "16550"
  # dc_static = "10.210.4.243"
  # ip_type   = "INTERNAL"

  subnetworks = [
    {
      subnet_name   = "shs-np-use4-gke-10-210-1-0-24"
      subnet_ip     = "10.210.1.0/24"
      subnet_region = "us-east4"
      description   = "This is an initial placeholder and should be changed"
    },
    {
      subnet_name   = "shs-p-svpc-use4-10-210-32-0-24"
      subnet_ip     = "10.210.32.0/24"
      subnet_region = "us-east4"
      description   = "GKE Node Subnet Prod"
    },
    {
      subnet_name   = "shs-dr-svpc-usc1-10-211-6-0-24"
      subnet_ip     = "10.211.6.0/24"
      subnet_region = "us-central1"
      description   = "GKE Node Subnet DR"
    },
    
  ]

  secondary_ranges = {
    shared-services-gke = [
      {
        range_name    = "service-network",
        ip_cidr_range = "10.210.2.0/24",
      },
      {
        range_name    = "pod-network",
        ip_cidr_range = "10.210.3.0/24",
      },
    ],
    "shs-p-svpc-use4-10-210-32-0-24" = [
      {
        range_name    = "shs-p-svpc-use4-10-210-33-0-24",
        ip_cidr_range = "10.210.33.0/24",
      },
      {
        range_name    = "shs-p-svpc-use4-10-210-34-0-24",
        ip_cidr_range = "10.210.34.0/24",
      },
    ]
    "shs-dr-svpc-usc1-10-211-6-0-24" = [
      {
        range_name    = "shs-dr-svpc-usc1-10-211-7-0-24",
        ip_cidr_range = "10.211.7.0/24",
      },
      {
        range_name    = "shs-dr-svpc-usc1-10-211-8-0-24",
        ip_cidr_range = "10.211.8.0/24",
      },
    ],
  }

  vpc_firewall_rules = {
    fw-icmp = {
      description = "ICMP Allow"
      direction   = "INGRESS"
      action      = "allow"
      ranges = [
      "0.0.0.0/0"]
      sources              = []
      targets              = []
      use_service_accounts = false
      rules = [
        {
          protocol = "icmp"
          ports    = []
        }
      ]
      extra_attributes = {}

    }
  }

  ingress_firewall_rules = {
    iap-ssh-rdp = {
      description = "IAP RDP Allow"
      direction   = "INGRESS"
      action      = "allow"
      ranges = [
        "35.235.240.0/20",
      ]
      sources              = []
      targets              = []
      use_service_accounts = false
      rules = [
        {
          protocol = "tcp"
          ports    = ["3389", "22", "80", "8080", "443", "52773"]
        }
      ]
      extra_attributes = {}
    },
      gke-hcadapters-np-test = {
      description = "Added for ingress into GKE and mllp and dicom adapter test deployments"
      direction   = "INGRESS"
      action      = "allow"
      ranges = [
        "10.210.0.0/15",
        "35.191.0.0/16",
        "130.211.0.0/22"
      ]
      sources              = []
      targets              = ["gke-shared-services-gke-nonprod"]
      use_service_accounts = false
      rules = [
        {
          protocol = "TCP"
          ports    = ["2575", "10256"]
        }
      ]
      extra_attributes = {}
    },
    
  }
}
