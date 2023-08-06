resource "aws_instance" "bastion" {
  ami           = "ami-01dd271720c1ba44f"
  instance_type = "t2.micro"
  key_name      = var.key_name
  # vpc_security_group_ids      = [var.ssh_sg, var.vpc_traffic_sg, var.outside_traffic_sg]
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
  domain = "vpc"

  tags = {
    Name = "${var.project}-Bastion-ElaticIP"
  }
}

resource "aws_eip_association" "bastion" {
  instance_id   = aws_instance.bastion.id
  allocation_id = aws_eip.bastion.id
}

resource "null_resource" "this" {

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${var.user_home_directory}/.ssh/${var.key_name}.pem")
    host        = aws_eip.bastion.public_ip
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
