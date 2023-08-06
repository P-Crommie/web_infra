variable "project" {
  description = "Name to be used on all the resources as identifier. e.g. Project name, Application name"
  type        = string
  default     = "webapp"
}

variable "project_region" {
  description = "Region to setup the project"
  type        = string
  default     = "eu-west-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_bits" {
  description = "The number of subnet bits for the CIDR. For example, specifying a value 8 for this parameter will create a CIDR with a mask of /24."
  type        = number
  default     = 8
}

variable "user_home_directory" {
  default = "/home/crommie"
}

variable "key_name" {
  type    = string
  default = "web_key"
}

variable "ssh_allowed_cidr" {
  default = ["102.176.0.0/17"]
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    owner     = "crommie"
    terraform = "true"
  }
}
