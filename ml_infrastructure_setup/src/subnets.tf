resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = "${var.region}a"

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.1.2.0/24"
  availability_zone = "${var.region}a"

  tags = {
    Name = "private-subnet_1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.1.3.0/24"
  availability_zone = "${var.region}c"

  tags = {
    Name = "private-subnet_2"
  }
}
