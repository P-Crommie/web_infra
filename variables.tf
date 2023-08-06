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

variable "scaling_group_desired_capacity" {
  type    = number
  default = 3
}

variable "scaling_group_max_size" {
  type    = number
  default = 5
}

variable "scaling_group_min_size" {
  type    = number
  default = 3
}

variable "scaling_group_health_check_grace_period" {
  type    = number
  default = 300
}

variable "scaling_group_health_check_type" {
  type    = string
  default = "EC2"
}

variable "scaling_group_launch_template_verson" {
  type    = string
  default = "$Latest"
}


variable "scaling_group_instance_fresh_triggers" {
  type = list
  default = ["desired_capacity"]
}

variable "launch_template_image_id" {
  type    = string
  default = "ami-01dd271720c1ba44f"
}

variable "launch_template_instance_type" {
  type    = string
  default = "t3a.micro"
}

variable "launch_template_ebs_optimized" {
  type    = bool
  default = true
}

variable "launch_template_update_default_version" {
  type    = bool
  default = true
}

variable "launch_template_disable_api_stop" {
  type    = bool
  default = true
}

variable "launch_template_disable_api_termination" {
  type    = bool
  default = true
}

variable "launch_template_monitoring" {
  type    = bool
  default = true
}

variable "db_instance_engine" {
  type    = string
  default = "mysql"
}

variable "db_instance_engine_version" {
  type    = string
  default = "5.7"
}

variable "db_instance_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "db_instance_allocated_storage" {
  type    = number
  default = 20
}

variable "db_instance_max_allocated_storage" {
  type    = string
  default = 50
}

variable "db_instance_db_name" {
  type    = string
  default = "db"
}

variable "db_instance_username" {
  type    = string
  default = "dbuser"
}

variable "db_instance_password" {
  type    = string
  default = "dbpassword"
}

variable "db_instance_parameter_group_name" {
  type    = string
  default = "default.mysql5.7"
}

variable "db_instance_backup_retention_period" {
  type    = number
  default = 7
}

variable "db_instance_skip_final_snapshot" {
  type    = bool
  default = true
}

variable "enable_bastionHost" {
  type    = bool
  default = true
}

variable "bastionHost_ami" {
  type    = string
  default = "ami-01dd271720c1ba44f"
}

variable "bastionHost_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "null_resource_connection_user" {
  type = string
  default = "ubuntu"
}
