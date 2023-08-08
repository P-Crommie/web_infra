# Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-InternetGateWay"
  })
  depends_on = [aws_vpc.this]
}
