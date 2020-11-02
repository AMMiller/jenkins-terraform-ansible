provider "aws" {
    region = var.region
}

#resource "aws_key_pair" "ssh-key" {
#    key_name   = "ssh-key"
#    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCrhsd7dekcsDR4+fcRgc4YRMfidea6I2jr1tlkqy6fNFnvexlv/LYQO9ARja/owWhUVEnGnI8Y9XJGJf4EazGXUjX8FDBRIbB7NWCAOQJph8RvUSi/+ZGfwfEunlR5DFoUHaX8xI2iph3bRXQzl93WGhSCkoyfjKLaNr3kHKukiZx9vCAVkW+SpJ1p7gQMnhmI5HUZrXKO4o3T7J2SlRkHZytgVYgY5vWeflUVhg1OlREt6ss59RYysR7GcMauvyeYpR9VMxwXkNAow4MmYv1j8zwHjnaTRYpAlcxlmMaM3BW1sYBJPLzaqPyZw3IHQalY91doNODiFEKn4BOB5vL2lTyYxnCehP0ebRinxfYxceOBcn7r2rj22GebfjTEzM3eTxfDjAVN6Bk/AOlPtbS6luBZA5vQ0qDTbU2mLHbjnPrRhKu8FrWEMM7qv3KOI3uu1YIJEmwW5nxV9OtwK5EDIuYbUknzQW/7A4/7wzQtrCTFwxSNYdbMM4HRUpbaBOGbzwEbIqw9h38nKaUN3QjzaPW0DN0gZtF6kkt31QXd2PIbv5OVIlYTGNHIWx12HY2WVn8piYCpwYXWzcNLPe6yWKBxZbZsoprpN+F47czHES9ZBrrt6nz6zHVqI6ZTl8XFJr4kRlV7GQIw9Yh711rhswITXdzLRAmhOO4DqAt8Ww== amiller@yandex.ru"
#}

resource "aws_instance" "dev" {
    count = 1
    ami = var.ami_dev
    instance_type = var.instance_type_dev
    tags = {
        Name = "Maven server"
    }
    vpc_security_group_ids = [aws_security_group.dev_sec.id]
 #   key_name = "ssh-key"
    associate_public_ip_address = true

    // user_data = data.template_file.maven_tpl.rendered
}

resource "aws_instance" "prod" {
    depends_on = [aws_instance.dev]
    count = 1
    ami = var.ami_prod
    instance_type = var.instance_type_prod
    tags = {
        Name = "Tomcat server"
    }
    vpc_security_group_ids = [aws_security_group.prod_sec.id]
  #  key_name = "ssh-key"
    associate_public_ip_address = true

    // user_data = data.template_file.tomcat_tpl.rendered
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
