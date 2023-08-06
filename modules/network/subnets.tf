# get all available AZs in our region
data "aws_availability_zones" "this" {
  state = "available"

  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

#Public Subnets
resource "aws_subnet" "public" {
  count             = length(data.aws_availability_zones.this.zone_ids)
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.vpc_cidr, var.subnet_cidr_bits, count.index)
  availability_zone = data.aws_availability_zones.this.names[count.index]

  tags = {
    Name = "${var.project}-publicSubnet-${count.index}"
  }
  map_public_ip_on_launch = true
}

# Private Subnets
resource "aws_subnet" "private" {
  count             = length(data.aws_availability_zones.this.zone_ids)
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.vpc_cidr, var.subnet_cidr_bits, count.index + length(data.aws_availability_zones.this.zone_ids))
  availability_zone = data.aws_availability_zones.this.names[count.index]

  tags = {
    Name = "${var.project}-privateSubnet-${count.index}"
  }
}
