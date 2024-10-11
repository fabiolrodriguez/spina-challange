### - Use this block to create a new service ---###

module "service" {
  source = "./modules/ecs_service"
  name   = "nginx"
  container_name = "nginx"
  # image = "416572346136.dkr.ecr.us-east-2.amazonaws.com/test-nginx:latest"
  cluster = aws_ecs_cluster.test
  subnet_id1 = aws_subnet.private.id
  subnet_id2 = aws_subnet.private2.id
  vpc_id = aws_vpc.test.id
  health_check_path = "/"
  container_port = 80
  memory = 512
  cpu = 256
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.test.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = module.service.target_group_arn
    type             = "forward"
  }

}
### --- END of service block ---###