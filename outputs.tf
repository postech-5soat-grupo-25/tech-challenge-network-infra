output "vpc_id" {
  description = "O ID da VPC criada. Utilizado para associar recursos adicionais a esta VPC."
  value       = aws_vpc.vpc.id
}

output "public_subnet_id" {
  description = "O ID da sub-rede pública criada. Recursos que precisam ser acessíveis pela internet devem ser associados a esta sub-rede."
  value       = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  description = "O ID da sub-rede privada criada. Ideal para recursos que não devem ser expostos diretamente à internet, como bancos de dados."
  value       = aws_subnet.private_subnet.id
}

output "internet_gateway_id" {
  description = "O ID do Internet Gateway associado à VPC. Necessário para configurações avançadas de roteamento."
  value       = aws_internet_gateway.internet_gateway.id
}

output "postgres_security_group_id" {
  description = "O ID do grupo de segurança para o banco de dados PostgreSQL. Utilizar este ID para associar recursos que precisam se conectar ao banco de dados."
  value       = aws_security_group.postgres_security_group.id
}

output "postgres_subnet_group_name" {
  description = "O nome do grupo de sub-redes para o banco de dados PostgreSQL. Utilizado para associar instâncias do RDS a sub-redes específicas."
  value       = aws_db_subnet_group.postgres_subnet_group.name
}
