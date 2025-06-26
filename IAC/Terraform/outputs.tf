# RDS
output "rds_endpoint" {
  description = "RDS Endpoint"
  value       = aws_db_instance.mysql.endpoint
}

output "rds_identifier" {
  description = "RDS Identifier"
  value       = aws_db_instance.mysql.id
}

# VPC
output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

# Subnets
output "public_subnet_ids" {
  description = "Public Subnet IDs"
  value       = [aws_subnet.public_1.id, aws_subnet.public_2.id]
}

output "private_subnet_ids" {
  description = "Private Subnet IDs"
  value       = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id,
    aws_subnet.private_3.id,
    aws_subnet.private_4.id
  ]
}

# Internet Gateway
output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.gw.id
}

# NAT Gateway
output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value       = aws_nat_gateway.nat.id
}

output "nat_eip" {
  description = "Elastic IP associated with NAT Gateway"
  value       = aws_eip.nat.public_ip
}

# Route Tables
output "public_route_table_id" {
  description = "Public Route Table ID"
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "Private Route Table ID"
  value       = aws_route_table.private.id
}

# EKS
output "eks_cluster_name" {
  description = "EKS Cluster Name"
  value       = aws_eks_cluster.main.name
}

output "eks_cluster_endpoint" {
  description = "EKS Cluster API Server Endpoint"
  value       = aws_eks_cluster.main.endpoint
}

output "eks_cluster_certificate_authority" {
  description = "EKS Cluster CA"
  value       = aws_eks_cluster.main.certificate_authority[0].data
}

output "eks_nodegroup_name" {
  description = "EKS Node Group Name"
  value       = aws_eks_node_group.main.node_group_name
}

output "eks_node_instance_role_arn" {
  description = "IAM Role ARN for EKS Nodes"
  value       = aws_iam_role.eks_nodegroup_role.arn
}
