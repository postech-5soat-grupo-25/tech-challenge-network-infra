output "vpc_id" {
  description = "O ID da VPC criada. Utilizado para associar recursos adicionais a esta VPC."
  value       = module.vpc.id
}

