resource "aws_security_group" "frontend_allow_all" {
  name        = "${var.vpc_name}-allow-all"
  description = "Allow all Inbound traffic"
  vpc_id      = aws_vpc.main.id

  # Ingress rule block with dynamic iteration over service ports
  dynamic "ingress" {
    for_each = var.ingress_value
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      security_groups = [module.front_end_alb.this_security_group_id] # Allow traffic from any IP
    }
  }

  # Egress rule block
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [module.back_end_alb.this_security_group_id] # Allow outbound traffic only to backend alb sg
  }

  # Tags block
  tags = {
    Name = "${var.vpc_name}-allow-all"
  }
}