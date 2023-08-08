variable "private_subnet" {
  type = list(any)
}
variable "public_subnet" {
  type = list(any)
}
variable "asg_sg" {}
variable "https_sg" {}
variable "http_sg" {}
variable "db_sg" {}
variable "ssh_sg" {}
variable "vpc_traffic_sg" {}

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

variable "scaling_group_desired_capacity" {
  type = number
}

variable "scaling_group_max_size" {
  type = number
}

variable "scaling_group_min_size" {
  type = number
}

variable "scaling_group_health_check_grace_period" {
  type = number
}

variable "scaling_group_health_check_type" {
  type = string
}

variable "scaling_group_launch_template_verson" {
  type = string
}

variable "scaling_group_instance_fresh_triggers" {
  type = list(any)
}

variable "launch_template_image_id" {
  type = string
}

variable "launch_template_instance_type" {
  type = string
}

variable "launch_template_ebs_optimized" {
  type = bool
}

variable "launch_template_update_default_version" {
  type = bool
}

variable "launch_template_disable_api_stop" {
  type = bool
}

variable "launch_template_disable_api_termination" {
  type = bool
}

variable "launch_template_monitoring" {
  type = bool
}

variable "db_instance_engine" {
  type = string
}

variable "db_instance_engine_version" {
  type = string
}

variable "db_instance_instance_class" {
  type = string
}

variable "db_instance_allocated_storage" {
  type = number
}

variable "db_instance_max_allocated_storage" {
  type = string
}

variable "db_instance_db_name" {
  type = string
}

variable "db_instance_username" {
  type = string
}

variable "db_instance_password" {
  type = string
}

variable "db_instance_parameter_group_name" {
  type = string
}

variable "db_instance_backup_retention_period" {
  type = number
}

variable "db_instance_skip_final_snapshot" {
  type = bool
}

variable "enable_bastionHost" {
  type = bool
}

variable "bastionHost_ami" {
  type = string
}

variable "bastionHost_instance_type" {
  type = string
}

variable "null_resource_connection_user" {
  type = string
}

variable "tags" {
  type = map(any)
}
