output "private_subnet" {
  value = aws_subnet.private[*].id
}

output "public_subnet" {
  value = aws_subnet.public[*].id
}

output "asg_sg" {
  value = aws_security_group.asg.id
}

output "https_sg" {
  value = aws_security_group.https.id
}

output "http_sg" {
  value = aws_security_group.http.id
}


output "db_sg" {
  value = aws_security_group.db.id
}

output "ssh_sg" {
  value = aws_security_group.ssh.id
}

output "vpc_traffic_sg" {
  value = aws_security_group.vpc_traffic.id
}

output "vpc_id" {
  value = aws_vpc.this.id
}
