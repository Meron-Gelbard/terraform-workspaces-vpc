resource "aws_route_table" "nat-rt" {
  vpc_id = aws_vpc.VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NATGW.id
  }
  tags = {
    Name = "${terraform.workspace}-natgw-route-table"
  }
}

resource "aws_route_table" "igw-rt" {
  vpc_id = aws_vpc.VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    Name = "${terraform.workspace}-igw-route-table"
  }
}

locals {
    private_sn_ids = { for i, subnet in aws_subnet.private_sn : i => subnet.id }
    public_sn_ids = { for i, subnet in aws_subnet.public_sn : i => subnet.id }
}

resource "aws_route_table_association" "public_subnet_asso" {
    for_each = local.public_sn_ids

    subnet_id      = each.value
    route_table_id = aws_route_table.igw-rt.id
}

resource "aws_route_table_association" "private_subnet_asso" {
    for_each = local.private_sn_ids

    subnet_id      = each.value
    route_table_id = aws_route_table.nat-rt.id
}