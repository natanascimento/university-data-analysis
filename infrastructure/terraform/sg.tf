# Creating a Security Group for University Database
resource "aws_security_group" "university-sg" {

  depends_on = [
    aws_vpc.custom,
    aws_subnet.subnet1
  ]

  description = "SSH, POSTGRESQL, PGADMIN"

  # Name of the security Group!
  name = "university-sg"
  
  # VPC ID in which Security group has to be created!
  vpc_id = aws_vpc.custom.id

  # Created an inbound rule for ssh access!
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Created an inbound rule for database
  ingress {
    description = "POSTGRESQL"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Created an inbound rule for pgadmin
  ingress {
    description = "PGADMIN"
    from_port   = 18080
    to_port     = 18080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Created an inbound rule for api
  ingress {
    description = "DATAAPI"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outward Network Traffic for the database
  egress {
    description = "output from database"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}