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

variable public_key_path {
  type        = string
  default     = "key.pub"
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