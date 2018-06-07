#vairable

variable "cluster-name" {
  default = "AWS-eks-SAMPLE"
  type    = "string"
}

variable "region" {
  default     = "us-east-1"
  description = "Region"
}

variable "key_name" {
  default     = "admin-key"
  description = "Default AWS Key"
}

variable "ami" {
  default = "ami-dea4d5a1"
}

variable "vpc" {
  default = "10.0.0.0/16"
}

variable "env" {
  default = "live"
}
