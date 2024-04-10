variable "project_id" {
  description = "The Google Cloud Project ID."
  type        = string
}

variable "project" {
  description = "The application project name"
  type        = string
  default     = "my-application"
}

variable "regions" {
  description = "A set of regions to use for the deployment"
  type        = set(string)
  default     = ["us-central1"]
}

variable "subnet_cidrs" {
  type        = map(string)
  description = "Subnet CIDR for VPC"
  default = {
    us-central1 = "10.1.1.0/24"
  }
}

variable "machine_type" {
  description = "The size of the VM instances."
  type        = string
  default     = "e2-micro"
}

variable "preemptible" {
  type    = bool
  default = false
}

variable "instance_count" {
  description = "Number of instances to provision."
  type        = number
  default     = 1

  validation {
    condition     = var.instance_count > 0 && var.instance_count <= 5
    error_message = "Instance count must be between 1 and 5."
  }
}

variable "startup_script" {
  type = string
}
