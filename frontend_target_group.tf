resource "aws_lb_target_group" "frontend_tg" {
  name     = "frontendtg"
  port     = 8501
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}
