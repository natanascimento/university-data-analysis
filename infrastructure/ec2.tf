#ID do recurso
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
#Informando o tipo da instancia a ser alocada e definindo um alias
resource "aws_instance" "university-data-analysis-master01" {
  #Informando o recurso
  ami           = data.aws_ami.ubuntu.id
  #Informando a instancia
  instance_type = "t2.medium"
  #Informando a VPC
  vpc_security_group_ids = [ aws_security_group.allow_ssh.id ,  aws_security_group.allow_database.id ,  aws_security_group.allow_pgadmin.id ]
  #Informando a subnet
  subnet_id = aws_subnet.university-data-analysis.id
  #Definindo um nome
  tags = {
    Name = "university-data-analysis-master01"
  }
  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = "${file("~/.ssh/terraform/")}"
    host = "aws_instance.instance.private_ip"
  } 

  provisioner "remote-exec" {
    inline = ["sudo apt-get update",
    "sudo apt-get install / apt-transport-https / ca-certificates / curl / gnupg-agent / software-properties-common",
    "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
    "apt-key fingerprint 0EBFCD88",
    "add-apt-repository /'deb [arch=amd64] https://download.docker.com/linux/ubuntu / $(lsb_release -cs) / stable'",
    "apt-get update",
    "apt-get install docker-ce docker-ce-cli containerd.io"]
  }
  provisioner "remote-exec" {
    inline = ["sudo curl -L 'https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)' -o /usr/local/bin/docker-compose",
    "sudo chmod +x /usr/local/bin/docker-compose"]
  }
  provisioner "remote-exec" {
    inline = ["sudo apt-get install git-all",
    "cd /home/",
    "git clone https://github.com/natanascimento/university-data-analysis.git",
    "cd /university-data-analysis/",
    "docker-compose up -d"]
  }
}