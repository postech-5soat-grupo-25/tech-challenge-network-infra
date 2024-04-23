variable "aws_region" {
  description = "A região da AWS onde os recursos serão criados."
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "O bloco CIDR para a VPC. Este bloco define o espaço de endereçamento IP da VPC, permitindo a comunicação interna entre os recursos."
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "O bloco CIDR para a sub-rede pública. Recursos nesta sub-rede podem ser acessados da internet."
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr_1" {
  description = "O bloco CIDR para a primeira sub-rede privada. Recursos nesta sub-rede não podem ser acessados diretamente da internet."
  default     = "10.0.2.0/24"
}

variable "private_subnet_cidr_2" {
  description = "O bloco CIDR para a segunda sub-rede privada. Recursos nesta sub-rede não podem ser acessados diretamente da internet."
  default     = "10.0.3.0/24"
}

variable "availability_zone" {
  description = "A zona de disponibilidade para as sub-redes. Zonas de disponibilidade são locais físicos distintos dentro de uma região da AWS que são projetados para serem isolados de falhas."
  default     = "us-east-1a"
}

variable "postgres_security_group_ingress_cidr_blocks" {
  description = "Blocos CIDR permitidos para acessar o banco de dados PostgreSQL. Isso define quais endereços IP podem iniciar conexões ao banco de dados."
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "postgres_port" {
  description = "A porta na qual o banco de dados PostgreSQL é acessível. A porta padrão para PostgreSQL é 5432, mas pode ser alterada por motivos de segurança ou configuração."
  type        = number
  default     = 5432
}

variable "postgres_security_group_egress_cidr_blocks" {
  description = "Blocos CIDR para as regras de saída do grupo de segurança. Isso define para quais endereços IP o banco de dados pode iniciar conexões, geralmente configurado para permitir acesso à internet."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}