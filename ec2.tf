# DATA BLOCK PULLING A GENERIC UBUNTU AMI
# WILL BE REPLACED WITH PACKER AMI IN THE FUTURE

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    values = [ "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*" ]
  }

  owners = [ "099720109477" ]
}

data "aws_ami" "vulnerable-db" {
  most_recent = true

  filter {
    name = "name"
    values = [ "vulnerable-db-ami-*" ]
  }

  owners = [ "self" ]
}

# EC2 WEB SERVER IN PUBLIC SUBNET

resource "aws_instance" "web_server" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id = aws_subnet.public_subnet.id
  vpc_security_group_ids = [ aws_security_group.web_security_group.id ]
  associate_public_ip_address = true

  tags = {
    Name = "web-server"
  }
}

resource "aws_instance" "db_server" {
  ami = data.aws_ami.vulnerable-db.id
  instance_type = "t3.micro"
  subnet_id = aws_subnet.public_subnet.id
  vpc_security_group_ids = [ aws_security_group.db_security_group.id ]
  associate_public_ip_address = true

  tags = {
    Name = "db-server"
  }
}

