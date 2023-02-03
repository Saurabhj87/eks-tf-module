locals {
  tags = {
    Example    = "test"
    GithubRepo = "terraform-aws-vpc"
    GithubOrg  = "terraform-aws-modules"
  }
}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

# Create Web Public Subnet
resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  availability_zone       = "ap-south-1a"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "Main"
  }
}
# Create Web Public Subnet
resource "aws_subnet" "main2" {
  vpc_id                  = aws_vpc.main.id
  availability_zone = "ap-south-1b"
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "Main2"
  }
}
# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "locals"
  }
}


module "eks" {
  source             = "../"
  subnet_private_ids = ["${aws_subnet.main.id}", "${aws_subnet.main2.id}"]
  eks_iam_role_name  = "Test-role-for-eks"
  eks_cluster_name   = "test-cluster-eks"
  tags               = local.tags
}