resource "aws_instance" "bastion" {
  count                       = var.enable_bastionHost == true ? 1 : 0
  ami                         = var.bastionHost_ami
  instance_type               = var.bastionHost_instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.ssh_sg, var.vpc_traffic_sg]
  subnet_id                   = var.public_subnet[1]
  associate_public_ip_address = false
  user_data                   = filebase64("${path.module}/userdata/bastion.sh")

  root_block_device {
    volume_size           = 15
    delete_on_termination = true
    volume_type           = "gp2"

    tags = {
      Name = "${var.project}-bastion-host-volume"
    }
  }

  tags = {
    Name = "${var.project}-bastion"
  }

  lifecycle {
    ignore_changes = [
      associate_public_ip_address,
    ]
  }
}

resource "aws_eip" "bastion" {
  count  = var.enable_bastionHost == true ? 1 : 0
  domain = "vpc"

  tags = {
    Name = "${var.project}-Bastion-ElaticIP"
  }
}

resource "aws_eip_association" "bastion" {
  count         = var.enable_bastionHost == true ? 1 : 0
  instance_id   = aws_instance.bastion[0].id
  allocation_id = aws_eip.bastion[0].id
}

resource "null_resource" "this" {
  count = var.enable_bastionHost == true ? 1 : 0
  connection {
    type        = "ssh"
    user        = var.null_resource_connection_user
    private_key = file("${var.user_home_directory}/.ssh/${var.key_name}.pem")
    host        = aws_eip.bastion[0].public_ip
    timeout     = 2
  }

  provisioner "file" {
    source      = "${var.user_home_directory}/.ssh/${var.key_name}.pem"
    destination = "/home/ubuntu/.ssh/${var.key_name}.pem"
  }

  depends_on = [
    aws_db_instance.this
  ]
}
