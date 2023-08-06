resource "aws_launch_template" "this" {
  name          = "${var.project}-LaunchTemplate"
  image_id      = "ami-01dd271720c1ba44f"
  instance_type = "t3a.micro"

  # vpc_security_group_ids = [var.vpc_traffic_sg, var.asg_sg, var.outside_traffic_sg]
  vpc_security_group_ids = [var.vpc_traffic_sg, var.asg_sg]
  key_name               = var.key_name

  user_data              = filebase64("${path.module}/userdata/httpd.sh")
  ebs_optimized          = true
  update_default_version = true
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = 30
      volume_type = "gp2"
    }
  }

  disable_api_stop        = true
  disable_api_termination = true

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.project}-LaunchTemplate"
    }
  }
}
