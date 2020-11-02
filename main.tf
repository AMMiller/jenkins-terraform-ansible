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

#resource "aws_vpc" "boxfuse_vpc" {
#    cidr_block = var.cidr_block_vpc

#    tags = {
#        Name = var.common_tag
#    }
#}

#resource "aws_subnet" "boxfuse_subnet" {
#    vpc_id            = aws_vpc.boxfuse_vpc.id
#    cidr_block        = var.cidr_block_subnet
#    availability_zone = var.zone

#    tags = {
#        Name = var.common_tag
#    }
#}

resource "aws_key_pair" "ssh-key" {
    key_name   = "ssh-key"
    public_key = var.public_key_material
}

#resource "aws_network_interface" "dev_if" {
#    subnet_id   = aws_subnet.boxfuse_subnet.id
#    private_ips = [var.private_ip_dev]

#    tags = {
#        Name = "primary_network_interface"
#    }
#}

resource "aws_instance" "dev" {
    count = 1
    ami = var.ami_dev
    instance_type = var.instance_type_dev

    tags = {
        Name = "boxfuse-dev"
    }

    key_name: aws_key_pair.ssh_key
#    network_interface {
#        network_interface_id = aws_network_interface.dev_if.id
#        device_index         = 0
#    }

    vpc_security_group_ids = [aws_security_group.dev_sec.id]
    associate_public_ip_address = true

}

#resource "aws_network_interface" "prod_if" {
#    subnet_id   = aws_subnet.boxfuse_subnet.id
#    private_ips = [var.private_ip_prod]

#    tags = {
#        Name = "primary_network_interface"
#    }
#}

resource "aws_instance" "prod" {
    depends_on = [aws_instance.dev]
    count = 1
    ami = var.ami_prod
    instance_type = var.instance_type_prod

    tags = {
        Name = "boxfuse-prod"
    }

    key_name: aws_key_pair.ssh_key
#    network_interface {
#        network_interface_id = aws_network_interface.prod_if.id
#        device_index         = 0
#    }

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


