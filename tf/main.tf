# Create a VPC: A virtual private cloud is an on-demand configurable pool of
# shared resources allocated within a public cloud environment, providing
# a certain level of isolation between the different organizations using
# the resources

resource "aws_vpc" "iac_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "iac_vpc"
  }
}

# Create a Security Group for the instances: A security group controls the traffic that is allowed
# to reach and leave the resources that it is associated with.
# For example, after you associate a security group with an EC2 instance
# it controls the inbound and outbound traffic for the instance.

resource "aws_security_group" "iac" {
  name        = "SG"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.iac_vpc.id

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

resource "aws_security_group" "iac_bastion_sg" {
  name        = "iac_bastion_sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.iac_vpc.id


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

resource "aws_instance" "iac_bastion_host" {
  ami           = "ami-007b48239f2f40f93" # Ubuntu 22.4.0 LTS ARM
  instance_type = "a1.medium" # Cheapest possible
  key_name      = var.iac_kp
  subnet_id     = aws_subnet.iac_public_subnet.id
  vpc_security_group_ids = [aws_security_group.iac_bastion_sg.id]
  availability_zone = "eu-central-1b"
  associate_public_ip_address = true # very important or it won't be reachable!


  tags = {
    Name = "iac_bastion_host"
  }
}


# Create 3 EC2 Instances: a VM running on AWS cloud, from console search for
# EC2 Instance

resource "aws_instance" "iac_instance" {
  count = 3
  ami = "ami-007b48239f2f40f93" # ubuntu 22.4.0 LTS ARM
  instance_type = "a1.medium" # cheapest possible (ARM)
  key_name = var.iac_kp # create a key pair on AWS console and include it in
                        # variables.tf
  subnet_id = aws_subnet.iac_internal_subnet.id
  vpc_security_group_ids = [aws_security_group.iac.id]
  availability_zone = "eu-central-1b"
  tags = {
    Name = "iac_instance-${count.index}"
  }
}
