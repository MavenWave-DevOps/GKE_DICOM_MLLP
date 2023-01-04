module "network" {
  source          = "terraform-google-modules/network/google"
  version         = "6.0.0"
  project_id      = var.project
  network_name    = var.network
  routing_mode    = "REGIONAL"
  shared_vpc_host = true


  subnets = [
    {
      subnet_name           = var.subnet[0]
      subnet_ip             = var.cidr[0]
      subnet_region         = var.region[0]
      subnet_private_access = true
    },
    {
      subnet_name           = var.subnet[1]
      subnet_ip             = var.cidr[1]
      subnet_region         = var.region[1]
      subnet_private_access = true
    }
  ]

}