# Define a região da AWS onde os recursos serão criados
provider "aws" {
  region = var.aws_region
}

# Prefixo local para nomear os recursos e facilitar a identificação
locals {
  prefix = "postech-5soat-grupo-25"
}

# Cria uma VPC (Virtual Private Cloud) para prover um espaço de rede isolado na AWS
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${local.prefix}-vpc"
  }
}

# Sub-rede pública onde os recursos podem receber IPs públicos e ser acessados da internet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone
  tags = {
    Name = "${local.prefix}-public-subnet"
  }
}

# Sub-rede privada para recursos que não devem ser acessados diretamente da internet
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_cidr
  map_public_ip_on_launch = false
  availability_zone       = var.availability_zone
  tags = {
    Name = "${local.prefix}-private-subnet"
  }
}

# Gateway de Internet para permitir acesso à internet a partir da sub-rede pública
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${local.prefix}-internet-gateway"
  }
}

# Tabela de rotas para direcionar o tráfego da sub-rede pública para o gateway de internet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "${local.prefix}-public-route-table"
  }
}

# Associação da tabela de rotas com a sub-rede pública para efetivar as regras de roteamento
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# Grupo de sub-redes com acesso ao banco de dados PostgreSQL
resource "aws_db_subnet_group" "postgres_subnet_group" {
  name       = "${local.prefix}-rds-subnet-group"
  subnet_ids = [aws_subnet.private_subnet.id]
}

# Grupo de segurança para o banco de dados PostgreSQL, definindo regras de acesso
resource "aws_security_group" "postgres_security_group" {
  name        = "${local.prefix}-postgres-security-group"
  description = "Security Group para PostgreSQL database"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = var.postgres_port
    to_port     = var.postgres_port
    protocol    = "tcp"
    cidr_blocks = var.postgres_security_group_ingress_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.postgres_security_group_egress_cidr_blocks
  }
}