provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "backend_sg" {
  name        = "backend-sg"
  description = "Allow HTTP and SSH"
  #   vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "keypair" {
  key_name   = "terraform-keypair"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "backend_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.backend_sg.id]
  key_name               = aws_key_pair.keypair.key_name
  user_data              = file("user_data.sh")

  tags = {
    Name = "eldorado-challenge-backend-instance"
  }
}

