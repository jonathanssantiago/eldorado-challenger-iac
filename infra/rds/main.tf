resource "aws_db_subnet_group" "eldorado_db_subnet_group" {
  name        = "eldorado-db-subnet-group"
  description = "Subnet group for Eldorado RDS"
  subnet_ids  = var.private_subnets

  tags = {
    Name        = "eldorado-db-subnet-group"
    Environment = var.environment
    Project     = "eldorado-challenge"
  }
}

resource "aws_security_group" "eldorado_db_sg" {
  name        = "eldorado-db-sg"
  description = "Security group for Eldorado RDS"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.ec2_sg_id]
    description     = "MySQL/Aurora from EC2 instances"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name        = "eldorado-db-sg"
    Environment = var.environment
    Project     = "eldorado-challenge"
  }
}

resource "aws_db_parameter_group" "eldorado_db_param_group" {
  name        = "eldorado-mysql-param-group"
  family      = "mysql5.7"
  description = "MySQL parameter group for Eldorado"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }

  tags = {
    Name        = "eldorado-mysql-param-group"
    Environment = var.environment
    Project     = "eldorado-challenge"
  }
}

resource "aws_db_instance" "eldorado_db" {
  identifier             = "eldorado-db"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = var.db_instance_class
  allocated_storage      = 20
  storage_type           = "gp3"
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = aws_db_parameter_group.eldorado_db_param_group.name
  db_subnet_group_name   = aws_db_subnet_group.eldorado_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.eldorado_db_sg.id]
  multi_az               = true
  publicly_accessible    = true

  tags = {
    Name        = "eldorado-db"
    Environment = var.environment
    Project     = "eldorado-challenge"
  }
}
