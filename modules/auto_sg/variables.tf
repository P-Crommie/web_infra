variable "private_subnet" {}
variable "public_subnet" {}
variable "asg_sg" {}
variable "https_sg" {}
variable "http_sg" {}
# variable "outside_traffic_sg" {}
variable "db_sg" {}
variable "ssh_sg" {}
variable "vpc_traffic_sg" {}
variable "availability_zones" {}
variable "vpc_id" {}

variable "project" {
  description = "Name of the project deployment."
  type        = string
}

variable "key_name" {
  type = string
}

variable "user_home_directory" {
  type = string
}
