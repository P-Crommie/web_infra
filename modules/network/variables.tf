variable "vpc_cidr" {
  type        = string
}

variable "subnet_cidr_bits" {
  description = "The number of subnet bits for the CIDR. For example, specifying a value 8 for this parameter will create a CIDR with a mask of /24."
  type        = number
}

variable "project" {
  description = "Name of the project deployment."
  type        = string
}

variable "ssh_allowed_cidr" {
  type = list(any)
}