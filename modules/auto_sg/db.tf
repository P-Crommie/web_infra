resource "aws_db_subnet_group" "this" {
  name       = "${var.project}-db-subnetgroup"
  subnet_ids = var.private_subnet[*]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "this" {
  identifier              = "${var.project}-db"
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  max_allocated_storage   = 50
  db_name                 = "${var.project}db"
  username                = "dbuser"
  password                = "dbpassword"
  parameter_group_name    = "default.mysql5.7"
  backup_retention_period = 7
  vpc_security_group_ids  = [var.db_sg, var.vpc_traffic_sg]
  db_subnet_group_name    = aws_db_subnet_group.this.name
  skip_final_snapshot     = true

  timeouts {
    create = "3h"
    delete = "3h"
    update = "3h"
  }

  tags = {
    Name = "${var.project}-db"
  }
}

output "db_endpoint" {
  value = aws_db_instance.this.endpoint
}
