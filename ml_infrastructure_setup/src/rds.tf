resource "random_password" "db_password" {
  length           = 32
  override_special = "!?-_"
  special          = true
  min_upper        = 3
  min_lower        = 4
  min_numeric      = 3
}

resource "aws_db_instance" "ml_rds" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "16.4"
  instance_class       = "db.t4g.micro"
  db_name              = "mlopsdb"
  db_subnet_group_name = aws_db_subnet_group.ml_rds_subnet.name
  identifier           = "ml-rds"
  username             = "ml_user"
  password             = random_password.db_password.result
  parameter_group_name = "default.postgres16"
  publicly_accessible  = false
  skip_final_snapshot  = true

  vpc_security_group_ids = [aws_security_group.allow_ec2_rds.id]

  tags = {
    Name = "ML-RDS-Instance"
  }
}

resource "aws_db_subnet_group" "ml_rds_subnet" {
  name       = "ml-rds-subnets"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
}

resource "aws_security_group" "allow_ec2_rds" {
  name        = "allow_ec2_rds"
  vpc_id      = aws_vpc.main_vpc.id
  description = "Allow EC2 to access RDS"

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
