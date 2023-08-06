module "network" {
  source           = "./modules/network"
  project          = var.project
  vpc_cidr         = var.vpc_cidr
  subnet_cidr_bits = var.subnet_cidr_bits
  ssh_allowed_cidr = var.ssh_allowed_cidr
}

module "scaling_group" {
  source              = "./modules/auto_sg"
  project             = var.project
  vpc_id              = module.network.vpc_id
  private_subnet      = module.network.private_subnet
  public_subnet       = module.network.public_subnet
  https_sg            = module.network.https_sg
  http_sg             = module.network.http_sg
  asg_sg              = module.network.asg_sg
  db_sg               = module.network.db_sg
  ssh_sg              = module.network.ssh_sg
  # outside_traffic_sg  = module.network.outside_traffic_sg
  vpc_traffic_sg      = module.network.vpc_traffic_sg
  availability_zones  = module.network.availability_zones
  key_name            = var.key_name
  user_home_directory = var.user_home_directory
}

output "alb_public_dns" {
  value = module.scaling_group.alb_public_dns
}

output "db_endpoint" {
  value = module.scaling_group.db_endpoint
}
