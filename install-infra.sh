#!/bin/bash

#install curl

#url for terraform download
#For OS-X
if [ "$(uname)" == "Drawin" ]; then
  terraform_url=$(curl https://releases.hashicorp.com/terraform/0.11.4/terraform_0.11.4_darwin_amd64.zip?_ga=2.28639484.1360404239.1521656887-898126082.1520503029)

#For Linux
elif [ "$(uname)" == "Linux" ]; then
  terraform_url=https://releases.hashicorp.com/terraform/0.11.4/terraform_0.11.4_linux_amd64.zip?_ga=2.268955569.1360404239.1521656887-898126082.1520503029
fi

# create and move to directory
mkdir terraform && cd $_

#Download terraform
echo "downloading terraform"
curl -o terraform.zip $terraform_url

#unzip and install
unzip terraform.zip

if [ "$(uname)" == "Darwin" ]; then
  # Terraform Paths.
  export PATH=$PATH:~/terraform
  echo "PATH=\$PATH:\$HOME/terraform" >> ~/bash_profile
  git clone https://github.com/OmarEwedah/WordPress-terraform-Docker-Prometheus.git
  mv WordPress-terraform-Docker-Prometheus ~/
  cd ..
  cp ./key.pem ~/WordPress-terraform-Docker-Prometheus/ansible/
  cd ~/WordPress-terraform-Docker-Prometheus/terraform
  terraform init
  terraform apply

  # For Linux
elif [ "$(uname)" == "Linux" ]; then
    # Terraform Paths.
   export PATH=$PATH:$HOME/terraform
   echo "PATH=\$PATH:\$HOME/terraform" >> ~/bash_profile
   git clone https://github.com/OmarEwedah/WordPress-terraform-Docker-Prometheus.git
   mv WordPress-terraform-Docker-Prometheus ~/
   cd ..
   cp ./key.pem ~/WordPress-terraform-Docker-Prometheus/ansible/
   cd ~/WordPress-terraform-Docker-Prometheus/terraform
   terraform init
   terraform apply

   fi
