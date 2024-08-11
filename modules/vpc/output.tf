output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "subnet" {
  description = "The IDs of the subnet"
  value       = aws_subnet.public.id
}
