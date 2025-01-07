output "igw" {
  value = local.igw_enabled_subnets
}

output "subnets" {
  value = aws_subnet.main
}

