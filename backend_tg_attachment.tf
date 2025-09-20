resource "aws_lb_target_group_attachment" "backend_tg_attach" {
  count            = length(var.private_subnet_cidr)
  target_group_arn = aws_lb_target_group.backend_tg.arn
  target_id        = element(aws_instance.backend_ec2.*.id, count.index)
  port             = 80
}