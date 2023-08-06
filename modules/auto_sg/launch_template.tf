resource "aws_launch_template" "this" {
  name          = "${var.project}-LaunchTemplate"
  image_id      = var.launch_template_image_id
  instance_type = var.launch_template_instance_type

  vpc_security_group_ids = [var.vpc_traffic_sg, var.asg_sg]
  key_name               = var.key_name

  user_data              = filebase64("${path.module}/userdata/httpd.sh")
  ebs_optimized          = var.launch_template_ebs_optimized
  update_default_version = var.launch_template_update_default_version

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = 30
      volume_type = "gp2"
    }
  }

  disable_api_stop        = var.launch_template_disable_api_stop
  disable_api_termination = var.launch_template_disable_api_termination

  monitoring {
    enabled = var.launch_template_monitoring
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.project}-LaunchTemplate"
    }
  }
}
