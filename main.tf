module "network" {
  source           = "./modules/network"
  project          = var.project
  vpc_cidr         = var.vpc_cidr
  subnet_cidr_bits = var.subnet_cidr_bits
  ssh_allowed_cidr = var.ssh_allowed_cidr
}

module "scaling_group" {
  source                                  = "./modules/auto_sg"
  project                                 = var.project
  vpc_id                                  = module.network.vpc_id
  private_subnet                          = module.network.private_subnet
  public_subnet                           = module.network.public_subnet
  https_sg                                = module.network.https_sg
  http_sg                                 = module.network.http_sg
  asg_sg                                  = module.network.asg_sg
  db_sg                                   = module.network.db_sg
  ssh_sg                                  = module.network.ssh_sg
  vpc_traffic_sg                          = module.network.vpc_traffic_sg
  availability_zones                      = module.network.availability_zones
  key_name                                = var.key_name
  user_home_directory                     = var.user_home_directory
  scaling_group_desired_capacity          = var.scaling_group_desired_capacity
  scaling_group_max_size                  = var.scaling_group_max_size
  scaling_group_min_size                  = var.scaling_group_min_size
  scaling_group_health_check_grace_period = var.scaling_group_health_check_grace_period
  scaling_group_health_check_type         = var.scaling_group_health_check_type
  scaling_group_launch_template_verson    = var.scaling_group_launch_template_verson
  scaling_group_instance_fresh_triggers   = var.scaling_group_instance_fresh_triggers
  launch_template_image_id                = var.launch_template_image_id
  launch_template_instance_type           = var.launch_template_instance_type
  launch_template_ebs_optimized           = var.launch_template_ebs_optimized
  launch_template_update_default_version  = var.launch_template_update_default_version
  launch_template_disable_api_stop        = var.launch_template_disable_api_stop
  launch_template_disable_api_termination = var.launch_template_disable_api_termination
  launch_template_monitoring              = var.launch_template_monitoring
  db_instance_engine                      = var.db_instance_engine
  db_instance_engine_version              = var.db_instance_engine_version
  db_instance_instance_class              = var.db_instance_instance_class
  db_instance_allocated_storage           = var.db_instance_allocated_storage
  db_instance_max_allocated_storage       = var.db_instance_allocated_storage
  db_instance_db_name                     = var.db_instance_db_name
  db_instance_username                    = var.db_instance_username
  db_instance_password                    = var.db_instance_password
  db_instance_parameter_group_name        = var.db_instance_parameter_group_name
  db_instance_backup_retention_period     = var.db_instance_backup_retention_period
  db_instance_skip_final_snapshot         = var.db_instance_skip_final_snapshot
  enable_bastionHost                      = var.enable_bastionHost
  bastionHost_ami                         = var.bastionHost_ami
  bastionHost_instance_type               = var.bastionHost_instance_type
  null_resource_connection_user           = var.null_resource_connection_user
}

output "alb_public_dns" {
  value = module.scaling_group.alb_public_dns
}

output "db_endpoint" {
  value = module.scaling_group.db_endpoint
}
