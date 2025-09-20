resource "aws_lb_target_group" "backend_tg" {
  name     = "backendtg"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}
