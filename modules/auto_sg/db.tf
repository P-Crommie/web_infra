resource "aws_db_subnet_group" "this" {
  name       = "${var.project}-db-subnetgroup"
  subnet_ids = var.private_subnet[*]

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-db-SubnetGroup"
  })
}

resource "aws_db_instance" "this" {
  identifier              = "${var.project}-db"
  engine                  = var.db_instance_engine
  engine_version          = var.db_instance_engine_version
  instance_class          = var.db_instance_instance_class
  allocated_storage       = var.db_instance_allocated_storage
  max_allocated_storage   = var.db_instance_max_allocated_storage
  db_name                 = var.db_instance_db_name
  username                = var.db_instance_username
  password                = var.db_instance_password
  parameter_group_name    = var.db_instance_parameter_group_name
  backup_retention_period = var.db_instance_backup_retention_period
  vpc_security_group_ids  = [var.db_sg, var.vpc_traffic_sg]
  db_subnet_group_name    = aws_db_subnet_group.this.name
  skip_final_snapshot     = var.db_instance_skip_final_snapshot

  timeouts {
    create = "1h"
    delete = "1h"
    update = "1h"
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-db"
  })
}

output "db_endpoint" {
  value = aws_db_instance.this.endpoint
}
