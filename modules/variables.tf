variable "subnet" {
  description = "Subnet"
  type        = list(string)
  default     = ["subnet1", "subnet2"]
}

variable "service_project" {
  description = "Service Projects"
  type        = list(string)
  default     = ["rwl-appeng-us-central1", "rwl-appeng-us-east4"]
}

variable "cidr" {
  description = "CIDR Ranges"
  type        = list(string)
  default     = ["10.50.0.0/16", "10.80.0.0/16"]
}
