resource "tls_private_key" "key" {
  algorithm = "RSA"
}

resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.key.public_key_openssh

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-key"
  })
}

resource "local_sensitive_file" "private_key" {
  filename        = "${var.user_home_directory}/.ssh/${var.key_name}.pem"
  content         = tls_private_key.key.private_key_pem
  file_permission = "0600"

}
