provider "aws" {
  access_key = "xxxxxxxxxxxxxxxxxxx"
  secret_key = "xxxxxxxxxxxxxxxxx"
  region = "eu-west-2"
}

resource "aws_instance" "ec2" {
  ami           = "ami-5ce55321"
  instance_type = "t2.medium"
  key_name = "cakesolutions"
  
  tags {
    Name = "blogging app"
  }
    root_block_device {
    volume_size = "50"
  }
}

resource "aws_key_pair" "terraform_ec2_key" {
  key_name = "cakesolutions"
  public_key = "ssh-rsa xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}

output "ip" {
  value = "${aws_instance.ec2.*.public_ip}"
}
