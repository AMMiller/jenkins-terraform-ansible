variable common_tag {
  type        = string
  default     = "boxfuse"
  description = "common tag for all instances"
}

variable region {
  type        = string
  default     = "us-east-2"
  description = "aws region"
}

variable zone {
  type        = string
  default     = "us-east-2a"
  description = "aws region"
}

variable public_key_material {
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCrhsd7dekcsDR4+fcRgc4YRMfidea6I2jr1tlkqy6fNFnvexlv/LYQO9ARja/owWhUVEnGnI8Y9XJGJf4EazGXUjX8FDBRIbB7NWCAOQJph8RvUSi/+ZGfwfEunlR5DFoUHaX8xI2iph3bRXQzl93WGhSCkoyfjKLaNr3kHKukiZx9vCAVkW+SpJ1p7gQMnhmI5HUZrXKO4o3T7J2SlRkHZytgVYgY5vWeflUVhg1OlREt6ss59RYysR7GcMauvyeYpR9VMxwXkNAow4MmYv1j8zwHjnaTRYpAlcxlmMaM3BW1sYBJPLzaqPyZw3IHQalY91doNODiFEKn4BOB5vL2lTyYxnCehP0ebRinxfYxceOBcn7r2rj22GebfjTEzM3eTxfDjAVN6Bk/AOlPtbS6luBZA5vQ0qDTbU2mLHbjnPrRhKu8FrWEMM7qv3KOI3uu1YIJEmwW5nxV9OtwK5EDIuYbUknzQW/7A4/7wzQtrCTFwxSNYdbMM4HRUpbaBOGbzwEbIqw9h38nKaUN3QjzaPW0DN0gZtF6kkt31QXd2PIbv5OVIlYTGNHIWx12HY2WVn8piYCpwYXWzcNLPe6yWKBxZbZsoprpN+F47czHES9ZBrrt6nz6zHVqI6ZTl8XFJr4kRlV7GQIw9Yh711rhswITXdzLRAmhOO4DqAt8Ww== amiller@yandex.ru"
  description = "public key for access aws hosts"
}


// ec2 instances

variable ami_prod {
  type        = string
  default     = "ami-0e82959d4ed12de3f"
  description = "ami for production server"
}

variable instance_type_prod {
  type        = string
  default     = "t2.micro"
  description = "instance type for prod server"
}

variable ami_dev {
  type        = string
  default     = "ami-0e82959d4ed12de3f"
  description = "ami for dev host"
}

variable instance_type_dev {
  type        = string
  default     = "t2.micro"
  description = "instance type for dev host"
}

// network

variable cidr_block_vpc {
  type        = string
  default     = "172.16.0.0/16"
  description = "cidr block for vpc"
}

variable cidr_block_subnet {
  type        = string
  default     = "172.16.10.0/24"
  description = "cidr block for subnet"
}

variable private_ip_dev {
    type        = string
    default     = "172.16.10.101"
    description = "private ip of dev server"
}

variable private_ip_prod {
    type        = string
    default     = "172.16.10.100"
    description = "private ip of prod server"
}