terraform {
  source = "../../modules//network"
}

include "root" {
  path = find_in_parent_folders()
}

locals {
  common = read_terragrunt_config(find_in_parent_folders("common.hcl")).locals
}

inputs = merge(
  local.common,
  {
    project            = local.common.project
    vpc_cidr           = "10.0.0.0/16"
    availability_zones = ["eu-west-1a", "eu-west-1b"]
    subnet_cidr_bits   = 8
    ssh_allowed_cidr   = ["41.218.192.0/19"]
})