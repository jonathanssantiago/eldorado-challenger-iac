resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "eldorado-vpc"
    Environment = var.environment
    Project     = "eldorado-challenge"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "eldorado-igw"
    Environment = var.environment
    Project     = "eldorado-challenge"
  }
}

resource "aws_subnet" "eldorado_public_subnet" {
  cidr_block              = var.public_subnet_cidr
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true
  availability_zone       = "${var.aws_region}a"

  tags = {
    Name        = "eldorado-public-subnet"
    Environment = var.environment
    Project     = "eldorado-challenge"
  }
}

resource "aws_subnet" "eldorado_private_subnet_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_a_cidr
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = false

  tags = {
    Name        = "eldorado-private-subnet-a"
    Environment = var.environment
    Project     = "eldorado-challenge"
  }
}

resource "aws_subnet" "eldorado_private_subnet_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_b_cidr
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = false

  tags = {
    Name        = "eldorado-private-subnet-b"
    Environment = var.environment
    Project     = "eldorado-challenge"
  }
}

# Route table for public subnet
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "eldorado-public-rt"
    Environment = var.environment
    Project     = "eldorado-challenge"
  }
}

# Associate public subnet with public route table
resource "aws_route_table_association" "public_rta" {
  subnet_id      = aws_subnet.eldorado_public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}
