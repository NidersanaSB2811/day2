resource "aws_instance" "frontend_ec2" {
  count                       = "${length(var.private_subnet_cidr)}"
  ami                         = var.ami_id
  key_name                    = var.key_name
  instance_type               = "t2.micro"
  vpc_security_group_ids      = ["${aws_security_group.frontend_allow_all.id}"]
  subnet_id                   = element(aws_subnet.pvt_subnet.*.id, count.index)


  tags = {
    Name = "${var.vpc_name}-frontend-ec2-${count.index}"
  }
}