provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "eldorado_backend_sg" {
  name        = "eldorado-backend-sg"
  description = "Allow HTTP, HTTPS and SSH"
  vpc_id      = var.vpc_id

  # HTTP access
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP from anywhere"
  }

  # HTTPS access
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS from anywhere"
  }

  # SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH from anywhere"
  }

  # Outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name        = "eldorado-backend-sg"
    Environment = var.environment
    Project     = "eldorado-challenge"
  }
}

resource "aws_key_pair" "keypair" {
  key_name   = "eldorado-terraform-keypair"
  public_key = file(var.public_key_path)
}

resource "aws_instance" "eldorado_backend_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet
  vpc_security_group_ids      = [aws_security_group.eldorado_backend_sg.id]
  key_name                    = aws_key_pair.keypair.key_name
  associate_public_ip_address = true
  user_data                   = file("${path.module}/user_data.sh")

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
    encrypted   = true
  }

  tags = {
    Name        = "eldorado-challenge-backend-instance"
    Environment = var.environment
    Project     = "eldorado-challenge"
  }
}
