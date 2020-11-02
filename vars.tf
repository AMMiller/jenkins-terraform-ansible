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
  description = "ami for dev server"
}

variable instance_type_dev {
  type        = string
  default     = "t2.micro"
  description = "instance type for dev server"
}

variable private_ip_dev {
    type        = string
    default     = "t2.micro"
    description = "private ip of dev server"
}

variable private_ip_prod {
    type        = string
    default     = "t2.micro"
    description = "private ip of prod server"
}