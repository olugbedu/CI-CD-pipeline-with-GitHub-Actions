variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}


variable "availability_zone" {
  description = "The description of the availability zone"
  type        = string
  default     = "eu-west-1a"
}
