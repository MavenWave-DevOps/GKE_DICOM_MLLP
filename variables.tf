variable "project" {
  description = "the project number"
  type        = string
  default     = "rwl-az-svpc-host"
}

variable "region" {
  description = "GCP Region"
  type        = list(string)
  default     = ["us-central1", "us-east4"]
}

variable "network" {
  description = "VPC Network"
  type        = string
  default     = "rwlsvpc"
}

#### VM variables ####


variable "sa_names" {
  description = "Service Account Names"
  type        = list(string)
  default     = ["svc-kubeproxy", "svc-win"]
}