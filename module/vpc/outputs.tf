output "vpc_id" {
  value = aws_vpc.nezvi_vpc.id
}
output "public_subnets_ids" {
  value = [for subnet in aws_subnet.public : subnet.id] 
  
}
output "private_subnets_id" {
  value = [for subnet in aws_subnet.private : subnet.id] 
}