variable "ec2" {
  description = "a list of maps defining the ec2 configuration"
  type        = object({
    ami            = string
    instance_type  = string
    subnet_id      = string
    vpc_id         = string
    key_name       = string
    #security_group = string
  })
}