# ---------------- VPC ----------------
resource "aws_vpc" "nezvi_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "nezvi-vpc"
  }
}

resource "aws_subnet" "public" {
  for_each = toset(var.public_subnets)

  vpc_id                  = aws_vpc.nezvi_vpc.id
  cidr_block              = each.value
  map_public_ip_on_launch = true

  tags = {
    Name = "public-${each.value}"
  }
}

resource "aws_subnet" "private" {
  for_each = toset(var.private_subnets)

  vpc_id     = aws_vpc.nezvi_vpc.id
  cidr_block = each.value

  tags = {
    Name = "private-${each.value}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.nezvi_vpc.id

  tags = {
    Name = "nezvi-igw"
  }
}


resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.nezvi_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_assoc" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_rt.id
}