# Create a security group to allow traffic to alb
resource "aws_security_group" "alb" {
  name_prefix = "alb-sg"
  vpc_id      = aws_vpc.test.id
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "SG for Spina ALB"
  }
}

# Create an Application Load Balancer
resource "aws_lb" "test" {
  name               = "test-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.public.id,aws_subnet.public2.id]
  security_groups    = [aws_security_group.alb.id]
  tags = {
    Name = "ALB for Spina"
  }
}
