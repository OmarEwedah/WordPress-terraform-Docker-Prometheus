provider "aws" {
  access_key = "xxxxxxxxxxxxxxxxxxx"
  secret_key = "xxxxxxxxxxxxxxxxx"
  region = "eu-west-2"
}

resource "aws_instance" "ec2" {
  ami           = "ami-5ce55321"
  instance_type = "t2.medium"
  
  tags {
    Name = "blogging app"
  }

}
