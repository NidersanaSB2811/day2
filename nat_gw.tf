resource "aws_nat_gateway" "nat_gw" {
  # count = length(var.public_subnet_cidr)
  allocation_id = aws_eip.nat_ip.id
  subnet_id     = aws_subnet.pub_subnet[0].id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}