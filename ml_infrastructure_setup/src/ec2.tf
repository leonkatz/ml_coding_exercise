resource "aws_instance" "ml_ec2" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.deployer.key_name

  user_data = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y docker.io docker-compose
  EOF

  tags = {
    Name = "ml_ec2"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}
