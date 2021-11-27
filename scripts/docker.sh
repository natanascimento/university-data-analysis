!/bin/bash
sudo apt-get update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu `lsb_release -cs` test"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
echo "Docker was installed!"
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local /bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo "Docker Compose was installed!"