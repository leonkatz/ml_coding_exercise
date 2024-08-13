resource "tls_private_key" "hadrian" {
  algorithm = "ED25519"
}

resource "aws_key_pair" "deployer" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.hadrian.public_key_openssh

  tags = {
    Name = var.key_pair_name
  }
}

