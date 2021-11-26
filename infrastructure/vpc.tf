#Definindo a VPC e o CIDR Block
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

#Definindo o internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

#Definindo a subnet para as máquinas Kubernet
resource "aws_subnet" "university-data-analysis" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "university-data-analysis"
  }
}
