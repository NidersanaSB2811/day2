resource "aws_security_group" "backend_allow_all" {
  name        = "${var.vpc_name}-backend-allow-all"
  description = "Allow all Inbound traffic"
  vpc_id      = aws_vpc.main.id

  # Ingress rule block with dynamic iteration over service ports
  dynamic "ingress" {
    for_each = var.ingress_value
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      security_groups = [module.back_end_alb.security_group_id] # Allow traffic from backend lb
    }
  }

  # Ingress from Bastion (for SSH)
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
    description     = "Allow SSH from bastion"
  }

  # Egress rule block
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic 
  }

  # Tags block
  tags = {
    Name = "${var.vpc_name}-allow-all"
  }
}