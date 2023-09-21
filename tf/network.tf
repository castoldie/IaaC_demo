# Create a Subnet: A subnetwork or subnet is a logical subdivision of an
# IP network. The practice of dividing a network into two or more networks
# is called subnetting. Computers that belong to the same subnet are addressed
# with an identical group of its most-significant bits of their IP addresses

resource "aws_subnet" "iac_internal_subnet" {
  vpc_id = aws_vpc.iac_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-central-1b"
  tags = {
    Name = "iac_internal_subnet"
  }
}

# Create a public subnet: this will be used to host a Bastion host in our VPC
# that will let us SSH into our instances that won't have a public IP for security
# reasons

resource "aws_subnet" "iac_public_subnet" {
  vpc_id     = aws_vpc.iac_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-central-1b"

  tags = {
    Name = "iac_public_subnet"
  }
}

# Create then a internet gateway (An internet gateway is a horizontally scaled
# redundant, and highly available VPC component that allows communication between
# your VPC and the internet. It supports IPv4 and IPv6 traffic. It does not cause
# availability risks or bandwidth constraints on your network traffic.):

resource "aws_internet_gateway" "iac_igw" {
  vpc_id = aws_vpc.iac_vpc.id

  tags = {
    Name = "iac_igw"
  }
}

# Then the route table (A route table contains a set of rules, called routes
# that are used to determine where network traffic from your subnet or gateway is directed.
# The main route table automatically comes with the VPC. The destination IP
# address and subnet are necessary as well.):

resource "aws_route_table" "iac_public_route_table" {
  vpc_id = aws_vpc.iac_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.iac_igw.id
  }

  tags = {
    Name = "iac_public_route_table"
  }
}

# Associate the route table with the public subnet

resource "aws_route_table_association" "iac_public_route_table_association" {
  subnet_id      = aws_subnet.iac_public_subnet.id
  route_table_id = aws_route_table.iac_public_route_table.id
}
