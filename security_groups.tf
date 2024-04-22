resource "aws_security_group" "app-sg" {
  name        = "${var.app_name}-sg"
  description = "VPC internal HTTP & SSH"
  vpc_id      = aws_vpc.VPC.id

  ingress {
    description = "Allow VPC internal HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.app_name}-sg"
  }

}

resource "aws_security_group" "ALB-sg" {
  name        = "${var.app_name}-ALB-sg"
  description = "ALB external HTTP"
  vpc_id      = aws_vpc.VPC.id

  ingress {
    description = "ALB external HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.app_name}-ALB-sg"
  }
}