terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}

provider "aws" {
    region = var.region
}

resource "aws_vpc" "boxfuse_vpc" {
    cidr_block = var.cidr_block_vpc

    tags = {
        Name = var.common_tag
    }
}

resource "aws_subnet" "boxfuse_subnet" {
    vpc_id            = aws_vpc.boxfuse_vpc.id
    cidr_block        = var.cidr_block_subnet
    availability_zone = var.zone

    tags = {
        Name = var.common_tag
    }
}

#resource "aws_key_pair" "ssh-key" {
#    key_name   = "ssh-key"
#    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCrhsd7dekcsDR4+fcRgc4YRMfidea6I2jr1tlkqy6fNFnvexlv/LYQO9ARja/owWhUVEnGnI8Y9XJGJf4EazGXUjX8FDBRIbB7NWCAOQJph8RvUSi/+ZGfwfEunlR5DFoUHaX8xI2iph3bRXQzl93WGhSCkoyfjKLaNr3kHKukiZx9vCAVkW+SpJ1p7gQMnhmI5HUZrXKO4o3T7J2SlRkHZytgVYgY5vWeflUVhg1OlREt6ss59RYysR7GcMauvyeYpR9VMxwXkNAow4MmYv1j8zwHjnaTRYpAlcxlmMaM3BW1sYBJPLzaqPyZw3IHQalY91doNODiFEKn4BOB5vL2lTyYxnCehP0ebRinxfYxceOBcn7r2rj22GebfjTEzM3eTxfDjAVN6Bk/AOlPtbS6luBZA5vQ0qDTbU2mLHbjnPrRhKu8FrWEMM7qv3KOI3uu1YIJEmwW5nxV9OtwK5EDIuYbUknzQW/7A4/7wzQtrCTFwxSNYdbMM4HRUpbaBOGbzwEbIqw9h38nKaUN3QjzaPW0DN0gZtF6kkt31QXd2PIbv5OVIlYTGNHIWx12HY2WVn8piYCpwYXWzcNLPe6yWKBxZbZsoprpN+F47czHES9ZBrrt6nz6zHVqI6ZTl8XFJr4kRlV7GQIw9Yh711rhswITXdzLRAmhOO4DqAt8Ww== amiller@yandex.ru"
#}

resource "aws_network_interface" "dev_if" {
    subnet_id   = aws_subnet.boxfuse_subnet.id
    private_ips = [var.private_ip_dev]

    tags = {
        Name = "primary_network_interface"
    }
}

resource "aws_instance" "dev" {
    count = 1
    ami = var.ami_dev
    instance_type = var.instance_type_dev

    tags = {
        Name = var.common_tag
    }

    network_interface {
        network_interface_id = aws_network_interface.dev_if.id
        device_index         = 1
    }

    vpc_security_group_ids = [aws_security_group.dev_sec.id]
    associate_public_ip_address = false

}

resource "aws_network_interface" "prod_if" {
    subnet_id   = aws_subnet.boxfuse_subnet.id
    private_ips = [var.private_ip_prod]

    tags = {
        Name = "primary_network_interface"
    }
}

resource "aws_instance" "prod" {
    depends_on = [aws_instance.dev]
    count = 1
    ami = var.ami_prod
    instance_type = var.instance_type_prod

    tags = {
        Name = "boxfuse"
    }

    network_interface {
        network_interface_id = aws_network_interface.prod_if.id
        device_index         = 1
    }

    vpc_security_group_ids = [aws_security_group.prod_sec.id]
    associate_public_ip_address = true
}

resource "aws_security_group" "dev_sec" {
    name = "dev_security_group"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "prod_sec" {
    name = "prod_security_group"
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}


