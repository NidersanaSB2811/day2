resource "aws_subnet" "pvt_subnet" {
  count = length(var.public_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = element(var.private_subnet_cidr,count.index)
  availability_zone = element(var.subnet_az,count.index)

  tags = {
    Name = "${var.vpc_name}-private-subnet-${count.index}"
  }
}