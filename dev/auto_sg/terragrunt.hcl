terraform {
  source = "../../modules//auto_sg"

  extra_arguments "db_vars" {
    commands = get_terraform_commands_that_need_vars()

    arguments = [
      "-var-file=${get_terragrunt_dir()}/../db.tfvars",
    ]
  }
}

include "root" {
  path = find_in_parent_folders()
}

dependency "network" {
  config_path = "../network"

  mock_outputs = {
    vpc_id         = "vpc_id_goes_here"
    private_subnet = ["private_subnets_goes_here", "private_subnets_goes_here"]
    public_subnet  = ["public_subnets_goes_here", "public_subnets_goes_here"]
    https_sg       = "https_sg_id_goes_here"
    http_sg        = "http_sg_id_goes_here"
    asg_sg         = "asg_sg_id_goes_here"
    db_sg          = "db_sg_id_goes_here"
    ssh_sg         = "ssh_sg_id_goes_here"
    vpc_traffic_sg = "vpc_traffic_sg_id_goes_here"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
}

locals {
  common = read_terragrunt_config(find_in_parent_folders("common.hcl")).locals
}

inputs = merge(
  local.common,
  {
    project                                 = local.common.project
    vpc_id                                  = dependency.network.outputs.vpc_id
    private_subnet                          = dependency.network.outputs.private_subnet
    public_subnet                           = dependency.network.outputs.public_subnet
    https_sg                                = dependency.network.outputs.https_sg
    http_sg                                 = dependency.network.outputs.http_sg
    asg_sg                                  = dependency.network.outputs.asg_sg
    db_sg                                   = dependency.network.outputs.db_sg
    ssh_sg                                  = dependency.network.outputs.ssh_sg
    vpc_traffic_sg                          = dependency.network.outputs.vpc_traffic_sg
    key_name                                = "web_key"
    user_home_directory                     = "/home/crommie"
    scaling_group_desired_capacity          = 3
    scaling_group_max_size                  = 5
    scaling_group_min_size                  = 3
    scaling_group_health_check_grace_period = 300
    scaling_group_health_check_type         = "EC2"
    scaling_group_launch_template_verson    = "$Latest"
    scaling_group_instance_fresh_triggers   = ["desired_capacity"]
    launch_template_image_id                = "ami-01dd271720c1ba44f"
    launch_template_instance_type           = "t3a.micro"
    launch_template_ebs_optimized           = true
    launch_template_update_default_version  = true
    launch_template_disable_api_stop        = true
    launch_template_disable_api_termination = true
    launch_template_monitoring              = true
    db_instance_engine                      = "mysql"
    db_instance_engine_version              = "5.7"
    db_instance_instance_class              = "db.t3.micro"
    db_instance_allocated_storage           = 20
    db_instance_max_allocated_storage       = 50
    db_instance_db_name                     = ""
    db_instance_username                    = ""
    db_instance_password                    = ""
    db_instance_parameter_group_name        = "default.mysql5.7"
    db_instance_backup_retention_period     = 7
    db_instance_skip_final_snapshot         = true
    enable_bastionHost                      = true
    bastionHost_ami                         = "ami-01dd271720c1ba44f"
    bastionHost_instance_type               = "t3a.micro"
    null_resource_connection_user           = "ubuntu"
})