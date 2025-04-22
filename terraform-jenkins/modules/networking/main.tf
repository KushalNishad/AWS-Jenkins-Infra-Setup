/* aws_vpc: It is the resource type provided by AWS. It creates an AWS VPC
proj_jenkins_us_east_1: It is a resource name or local identifier for the VPC resource. It allows you to
                        reference this VPC elsewhere (outputs, dependencies, or other resources) */
resource "aws_vpc" "proj_jenkins_us_east_1" {
  cidr_block = var.vpc_cidr
  tags = {
    Name        = var.vpc_name
    Environment = "development"
  }
}

# Public Subnet
resource "aws_subnet" "proj_jenkins_public_subnets" {
  count             = length(var.cidr_public_subnet) # Count Meta-Argument: Creates multiple resources dynamically based on the length of a list
  vpc_id            = aws_vpc.proj_jenkins_us_east_1.id
  cidr_block        = element(var.cidr_public_subnet, count.index)   # Element Function: Retrieves a unique CIDR block for each resource based on its index
  availability_zone = element(var.us_availability_zone, count.index) # Count.Index: Represents the current resource's index (starting from 0) to assign unique values

  tags = {
    Name        = "proj-jenkins-public-subnet-${count.index + 1}"
    Environment = "development"
  }
}

# Private Subnet
resource "aws_subnet" "proj_jenkins_private_subnets" {
  count             = length(var.cidr_private_subnet)
  vpc_id            = aws_vpc.proj_jenkins_us_east_1.id
  cidr_block        = element(var.cidr_private_subnet, count.index)
  availability_zone = element(var.us_availability_zone, count.index)

  tags = {
    Name        = "proj-jenkins-private-subnet-${count.index + 1}"
    Environment = "development"
  }
}

# Setup Internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.proj_jenkins_us_east_1.id
}

# Public Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.proj_jenkins_us_east_1.id

  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "proj-jenkins-public-rt"
  }
}

# Public Subnet Association
resource "aws_route_table_association" "public_rt_association" {
  count          = length(aws_subnet.proj_jenkins_public_subnets)
  subnet_id      = aws_subnet.proj_jenkins_public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

# Private Route Table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.proj_jenkins_us_east_1.id

  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }

  tags = {
    Name = "proj-jenkins-private-rt"
  }
}


# Private Subnet Association
resource "aws_route_table_association" "private_rt_association" {
  count          = length(aws_subnet.proj_jenkins_private_subnets)
  subnet_id      = aws_subnet.proj_jenkins_private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}