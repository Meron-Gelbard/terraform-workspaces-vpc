
resource "aws_instance" "web-app" {
    count = local.current_config.instance_count
    ami           = "ami-0c7217cdde317cfec"
    instance_type = local.current_config.instance_type
    subnet_id = element(aws_subnet.private_sn.*.id, 0)
    vpc_security_group_ids = [aws_security_group.app-sg.id]
    tags = {
        Name = "${var.app_name}-${terraform.workspace}-${count.index}"
    }
}

resource "aws_lb_target_group" "target_group" {
  name     = "${var.app_name}-${terraform.workspace}-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.VPC.id
}

resource "aws_lb_target_group_attachment" "attachment" {
    count = local.current_config.instance_count
    target_group_arn = aws_lb_target_group.target_group.arn
    target_id        = element(aws_instance.web-app.*.id, count.index)
}

resource "aws_lb" "load_balancer" {
  name               = "${var.app_name}-${terraform.workspace}-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ALB-sg.id]
  subnets            = [element(aws_subnet.public_sn.*.id, 0), element(aws_subnet.public_sn.*.id, 1)]

  enable_deletion_protection = false
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.target_group.arn
    type             = "forward"
  }
}