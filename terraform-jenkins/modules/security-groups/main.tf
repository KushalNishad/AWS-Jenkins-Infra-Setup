resource "aws_security_group" "ec2_sg_ssh_http" {
  name        = var.ec2_sg_name
  description = "Enable the Port 22(SSH) & Port 80(http)"
  vpc_id      = var.vpc_id

  tags = {
    Name = "Security Groups to allow SSH(22) and HTTP(80)"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allows_ssh" {
  security_group_id = aws_security_group.ec2_sg_ssh_http.id
  description       = "Allow remote SSH from anywhere"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allows_http" {
  security_group_id = aws_security_group.ec2_sg_ssh_http.id
  description       = "Allow HTTP request from anywhere"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allows_https" {
  security_group_id = aws_security_group.ec2_sg_ssh_http.id
  description       = "Allow HTTPS request from anywhere"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.ec2_sg_ssh_http.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_security_group" "ec2_jenkins_port_8080" {
  name        = var.ec2_jenkins_sg_name
  description = "Enable the port 8080 for jenkins"
  vpc_id      = var.vpc_id

  tags = {
    Name = "Security Groups to allow 8080 port to access jenkins"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allows_8080_jenkins" {
  security_group_id = aws_security_group.ec2_jenkins_port_8080.id
  description       = "Allow 8080 port to access jenkins"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 8080
  ip_protocol       = "tcp"
  to_port           = 8080
}
