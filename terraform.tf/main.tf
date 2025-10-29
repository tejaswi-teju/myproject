###################################################################
# VPC
###################################################################

resource "aws_vpc" "vpc-1" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "vpc-1"
    }
}

###################################################################
# PUBLIC SUBNET
###################################################################

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.vpc-1.id
    cidr_block = var.public_cidr
    tags = {
        Name = "public"
    }
}

###################################################################
# INTERNET GATEWAY
###################################################################

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc-1.id
    tags = {
        Name = "my-igw"
    }
} 

###################################################################
# ROUTE TABLE
###################################################################

resource "aws_route_table" "public_rtb" {
    vpc_id = aws_vpc.vpc-1.id
}

###################################################################
# SUBNET AND GATEWAY ASSOCIATION
###################################################################

resource "aws_route" "igwroute" {
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
    route_table_id = aws_route_table.public_rtb.id
}

###################################################################
# EC2
###################################################################
resource "aws_instance" "server1" {
    #ami = data.aws_ami.ubuntu.id
    ami = var.ami_id
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public.id
    associate_public_ip_address = "true"
    #key_name = aws_key_pair.mykey.id
    security_groups = [aws_security_group.my-sg1.id]
    tags = {
        Name = "server1"
    }
}

###################################################################
# AMI SELECTION
###################################################################

/*data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["self"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
} */

###################################################################
# CREATING KEY PAIR
###################################################################
/*resource "aws_key_pair" "mykey" {

}*/

###################################################################
# SECURITY GROUPS
###################################################################
resource "aws_security_group" "my-sg1" {
    tags = {
        Name = "my-sg1"
    }
    vpc_id = aws_vpc.vpc-1.id
    
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH from admin"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All outbound"
  }

}