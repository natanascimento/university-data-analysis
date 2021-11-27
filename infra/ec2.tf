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

  # Keyname and security group are obtained from the reference of their instances created above!
  # Here I am providing the name of the key which is already uploaded on the AWS console.
  key_name = "university-data-analysis"
  
  # Security groups to use!
  vpc_security_group_ids = [aws_security_group.university-sg.id]

  tags = {
   Name = "University_Database_From_Terraform"
  }

  # Installing required softwares into the system!
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("~/.aws/ssh/terraform/university-data-analysis.pem")
    host = self.public_ip
  }

  # Code for installing the softwares!
  provisioner "remote-exec" {
    inline = ["sudo apt-get update",
    "sudo apt-get install -y git-all",
    "cd /home/ubuntu",
    "sudo git clone https://github.com/natanascimento/university-data-analysis.git",
    "cd university-data-analysis/",
    "sudo cd infchmod +x scripts/docker.sh",
    "sudo sh scripts/docker.sh"]
  }
  provisioner "remote-exec" {
    inline = ["cd /home/ubuntu/university-data-analysis",
    "sudo docker-compose up -d"]
  }
}