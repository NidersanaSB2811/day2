resource "aws_eip" "nat_ip" {
  count = length(var.public_subnet_cidr)

  tags = {
    Name = "NAT EIP ${count.index}"
  }
}
