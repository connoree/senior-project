# SECURITY GROUP FOR WEB SERVER (PUBLIC)

resource "aws_security_group" "web_security_group" {
  name = "web-sg"
  description = "allow HTTP, HTTPS, & SSH traffic"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "Allow SSH"
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port = 443
    protocol = "tcp"
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# SECURITY GROUP FOR DB (PRIVATE)

resource "aws_security_group" "db_security_group" {
  name = "db-sg"
  description = "Security group for db"
  vpc_id = aws_vpc.main.id

#   ingress {
#     description = "Allow traffic from web server"
#     from_port = 3306
#     to_port = 3306
#     protocol = "tcp"
#     security_groups = [aws_security_group.web_security_group.id]
#   }

  ingress {
    description = "Allow SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # MISCONFIGURATION
  ingress {
    description = "Allow traffic from everywhere"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}