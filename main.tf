
resource "aws_vpc" "VPC" {
    cidr_block       = "10.0.0.0/16"
    tags = {
    Name = "${terraform.workspace}-vpc"
  }
}

resource "aws_internet_gateway" "IGW" {
    vpc_id = aws_vpc.VPC.id
    tags = {
    Name = "${terraform.workspace}-IGW"
  }
}

resource "aws_subnet" "private_sn" {
    count = local.current_config.subnet_count
    vpc_id = aws_vpc.VPC.id

    cidr_block = cidrsubnet("10.0.0.0/16", 8, count.index)
    availability_zone = element(var.AZs, count.index)

    tags = {
    Name = "${terraform.workspace}-private-${count.index}"
  }
}

resource "aws_subnet" "public_sn" {
    count = local.current_config.subnet_count
    vpc_id = aws_vpc.VPC.id

    cidr_block = cidrsubnet("10.0.0.0/16", 8, count.index + local.current_config.subnet_count)
    availability_zone = element(var.AZs, count.index)
    map_public_ip_on_launch = true

    tags = {
    Name = "${terraform.workspace}-public-${count.index}"
  }
}

resource "aws_eip" "NATGW-EIP" {}

resource "aws_nat_gateway" "NATGW" {
    allocation_id = aws_eip.NATGW-EIP.id
    subnet_id     = element(aws_subnet.public_sn.*.id, 0)

    tags = {
        Name = "${terraform.workspace}-NATGW"
    }
}



