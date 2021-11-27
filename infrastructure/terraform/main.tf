#Realizando uma requisição da hashicorp
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
#Informando para o Terraform, qual o provedor que será alocada a infraestrutura
# Após definir o provedor, será definido um perfil que este perfil é definido lá na "\.aws\credentials"
# E definimos por ultimo a região onde será alocada os recursos
provider "aws" {
  profile = "awseducate"
  region  = "us-east-1"
}