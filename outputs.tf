output "vpc_id" {
  description = "O ID da VPC criada. Utilizado para associar recursos adicionais a esta VPC."
  value       = aws_vpc.vpc.id
}

output "postgres_security_group_id" {
  description = "O ID do grupo de segurança para o banco de dados PostgreSQL. Utilizar este ID para associar recursos que precisam se conectar ao banco de dados."
  value       = aws_security_group.postgres_security_group.id
}

output "postgres_subnet_group_name" {
  description = "O nome do grupo de sub-redes para o banco de dados PostgreSQL. Utilizado para associar instâncias do RDS a sub-redes específicas."
  value       = aws_db_subnet_group.postgres_subnet_group.name
}
