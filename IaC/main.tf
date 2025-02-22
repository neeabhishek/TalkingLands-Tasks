terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.88.0" #Using the latest provider as per Terraform doc
    }
  }
}

#Create an IAM user on AWS console and attach the Admin access policy; 
#Copy the access and secret key and pass it in variable.tf
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

#EC2 instance resource block containing the Amazon machine image, instance type, and tags.
#We are using a free-tier ubuntu machine identified as Dev environment for hosting Ngnix server on Dev env for TalkingLands.
#We would be leveraging configuration management using providers - file and remote-exec for for hosting nginx.
#For this implementation we will not be attaching a VPC, subnet, routetable, NAT or Internet Gateway.
resource "aws_instance" "nginx_server" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.ec2_keypair.key_name
  vpc_security_group_ids      = [aws_security_group.nginx_server_sg.id]
  associate_public_ip_address = true

  tags = {
    Name       = "TalkingLands-Nginx-Server-${var.environment}"
    Enviroment = var.environment
  }

  provisioner "file" {
    source      = "setupNginx.sh"
    destination = "/tmp/setupNginx.sh"

  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod -R 755 /tmp/setupNginx.sh",
      "sudo /tmp/setupNginx.sh"
    ]

  }

  connection {
    type        = "ssh"
    user        = var.nginx_server_user
    host        = aws_instance.nginx_server.public_ip
    timeout     = "5m"
    private_key = tls_private_key.key_pair.private_key_pem
  }
}
#Keypair generation for accessing the EC2;
#We will be using tls_private_key, aws_key_pair, and local_file resource types for the above mentioned activity.
resource "tls_private_key" "key_pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_keypair" {
  key_name   = "ec2_keypair"
  public_key = tls_private_key.key_pair.public_key_openssh
}

resource "local_file" "ec2_private_key" {
  filename        = var.filename
  file_permission = var.file_permission
  content         = tls_private_key.key_pair.private_key_pem
}
#SG of the Nginx server
resource "aws_security_group" "nginx_server_sg" {
  name        = "TalkingLands-Nginx-${var.environment}-sg"
  description = "TalkingLands-Nginx-${var.environment}-sg"


  tags = {
    Name = "TalkingLands-Nginx-${var.environment}-sg"
  }

  ingress {
    description = "Allow SSH Port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr_blocks]
  }

  ingress {
    description = "Allow Nginx Port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.cidr_blocks]
  }

  egress {
    description = "Allow HTTPS port"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.cidr_blocks]
  }
  egress {
    description = "Allow Port 80 for fetching Ubuntu repo"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.cidr_blocks]
  }
}

output "public_ip_ec2" {
  value = aws_instance.nginx_server.public_ip
}
output "webserver_user" {
  value = var.nginx_server_user
}
