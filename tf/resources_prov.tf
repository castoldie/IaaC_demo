provider "aws" {
  region = "eu-central-1" # Frankfurt, Germany
}

# Create a VPC: A virtual private cloud is an on-demand configurable pool of
# shared resources allocated within a public cloud environment, providing
# a certain level of isolation between the different organizations using
# the resources

resource "aws_vpc" "IaC_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "IaC_vpc"
  }
}

# Create a Subnet: A subnetwork or subnet is a logical subdivision of an
# IP network. The practice of dividing a network into two or more networks
# is called subnetting. Computers that belong to the same subnet are addressed
# with an identical group of its most-significant bits of their IP addresses

resource "aws_subnet" "IaC_subnet" {
  vpc_id = aws_vpc.IaC_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-central-1b"
  tags = {
    Name = "IaC_subnet"
  }
}

# Create a public subnet: this will be used to host a Bastion host in our VPC
# that will let us SSH into our instances that won't have a public IP for security
# reasons

resource "aws_subnet" "IaC_public_subnet" {
  vpc_id     = aws_vpc.IaC_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-central-1b"

  tags = {
    Name = "IaC_public_subnet"
  }
}

# Create then a internet gateway (An internet gateway is a horizontally scaled
# redundant, and highly available VPC component that allows communication between
# your VPC and the internet. It supports IPv4 and IPv6 traffic. It does not cause
# availability risks or bandwidth constraints on your network traffic.):

resource "aws_internet_gateway" "IaC_igw" {
  vpc_id = aws_vpc.IaC_vpc.id

  tags = {
    Name = "IaC_igw"
  }
}

# Then the route table (A route table contains a set of rules, called routes
# that are used to determine where network traffic from your subnet or gateway is directed.
# The main route table automatically comes with the VPC. The destination IP
# address and subnet are necessary as well.):

resource "aws_route_table" "IaC_public_route_table" {
  vpc_id = aws_vpc.IaC_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IaC_igw.id
  }

  tags = {
    Name = "IaC_public_route_table"
  }
}

# Associate the route table with the public subnet

resource "aws_route_table_association" "IaC_public_route_table_association" {
  subnet_id      = aws_subnet.IaC_public_subnet.id
  route_table_id = aws_route_table.IaC_public_route_table.id
}



# Create a Security Group for the instances: A security group controls the traffic that is allowed
# to reach and leave the resources that it is associated with.
# For example, after you associate a security group with an EC2 instance
# it controls the inbound and outbound traffic for the instance.

resource "aws_security_group" "IaC" {
  name        = "SG"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.IaC_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create SG for Bastion host:

resource "aws_security_group" "IaC_bastion_sg" {
  name        = "IaC_bastion_sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.IaC_vpc.id


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create Bastion Host instance:

resource "aws_instance" "IaC_bastion_host" {
  ami           = "ami-007b48239f2f40f93" # Ubuntu 22.4.0 LTS ARM
  instance_type = "a1.medium" # Cheapest possible
  key_name      = var.IaC_kp
  subnet_id     = aws_subnet.IaC_public_subnet.id
  vpc_security_group_ids = [aws_security_group.IaC_bastion_sg.id]
  availability_zone = "eu-central-1b"
  associate_public_ip_address = true # very important or it won't be reachable!


  tags = {
    Name = "IaC_bastion_host"
  }
}


# Create 3 EC2 Instances: a VM running on AWS cloud, from console search for
# EC2 Instance

resource "aws_instance" "IaC_instance" {
  count = 3
  ami = "ami-007b48239f2f40f93" # ubuntu 22.4.0 LTS ARM
  instance_type = "a1.medium" # cheapest possible (ARM)
  key_name = var.IaC_kp # create a key pair on AWS console and include it in
                        # variables.tf
  subnet_id = aws_subnet.IaC_subnet.id
  vpc_security_group_ids = [aws_security_group.IaC.id]
  availability_zone = "eu-central-1b"
  tags = {
    Name = "IaC_instance-${count.index}"
  }
}
