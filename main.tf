#VPC
# Create a VPC to launch our instances into
resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc}"

  tags {
    Name = "${var.env}-eks-cluster"
    Environment  = "${var.env}"
    ManagedBy = "Terraform"
  }
}

#AWS Provider Details 

# Specify the provider and access details
provider "aws" {
  shared_credentials_file = "./credentials"
  profile                 = "live"
  region                  = "${var.region}"
}

# Using these data sources allows the configuration to be
# generic for any region.
data "aws_region" "current" {}

data "aws_availability_zones" "available" {}

# Not required: currently used in conjuction with using
# icanhazip.com to determine local laptop external IP
# to open EC2 Security Group access to the Kubernetes cluster.
# See laptop-external-ip.tf for additional information.
provider "http" {}




# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "${var.env}-igw"
    Environment = "${var.env}"
    ManagedBy = "Terraform"
  }
}


#  External IP
#
# This configuration is not required and is
# only provided as an example to easily fetch
# the external IP of your local laptop to
# configure inbound EC2 Security Group access
# to the Kubernetes cluster.
#


# Override with variable or hardcoded value if necessary
locals {
  laptop-external-cidr = "${chomp(data.http.laptop-external-ip.body)}/32"
}
