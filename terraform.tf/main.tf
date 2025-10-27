resource "aws_vpc" "vpc-1" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "vpc-1"
    }
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.vpc-1.id
    cidr_block = var.public_cidr
    tags = {
        Name = public
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc-1.id
    tags = {
        Name = "my-igw"
    }
} 

resource "aws_route_table" "public_rtb" {
    vpc_id = aws_vpc.vpc-1.id
}

resource "aws_route" "igwroute" {
    destination_cidr_block = 0.0.0.0/0
    gateway_id = aws_internet_gateway.id
    route_table_id = aws_route_table.public_rtb.id
}