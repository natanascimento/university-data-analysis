#Resource ID
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
# Creating an AWS instance for the University Database!
resource "aws_instance" "university-database" {

  depends_on = [
    aws_vpc.custom,
    aws_subnet.subnet1,
  ]
  
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.medium"
  subnet_id = aws_subnet.subnet1.id

  key_name = "university-key"
  
  # Security groups to use!
  vpc_security_group_ids = [aws_security_group.university-sg.id]

  tags = {
   Name = "University_Database"
  }

  # Connecting to the instance!
  connection {
    type = "ssh"
    user = "ubuntu"
    agent = false
    private_key = file("~/.aws/ssh/terraform/university-key.pem")
    host = self.public_ip
  }

  # Code for installing the softwares!
  provisioner "remote-exec" {
    inline = ["sudo apt-get update",
    "sudo apt-get install -y git-all",
    "cd /home/ubuntu",
    "sudo git clone https://github.com/natanascimento/university-data-analysis.git",
    "cd university-data-analysis/",
    "sudo chmod +x scripts/docker.sh",
    "sudo sh scripts/docker.sh"]
  }
  #Code to deploy the database into the instance!
  provisioner "remote-exec" {
    inline = ["cd /home/ubuntu/university-data-analysis",
    "sudo docker build -t university-data-analysis .",
    "sudo docker run -d -p 8080:8080 university-data-analysis"]
  }
  #Code to deploy the database into the instance!
  provisioner "remote-exec" {
    inline = ["cd /home/ubuntu/university-data-analysis",
    "sudo docker-compose up -d"]
  }
}