output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "subnet_id" {
  description = "The IDs of the subnet"
  value       = aws_subnet.public.id
}

output "aws_internet_gateway" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.igw.id
}