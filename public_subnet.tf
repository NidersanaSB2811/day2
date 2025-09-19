resource "aws_subnet" "pub_subnet" {
  count = length(var.public_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = element(var.public_subnet_cidr,count.index)
  availability_zone = element(var.subnet_az,count.index)

  tags = {
    Name = "${var.vpc_name}-public-subnet-${count.index}"
  }
}