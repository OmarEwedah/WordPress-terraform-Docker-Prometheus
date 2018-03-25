provider "aws" {
  access_key = "xxxxxxxxxxxxxxxxxxxxxx"
  secret_key = "xxxxxxxxxxxxxxx"
  region     = "eu-west-2"
}

resource "aws_security_group" "monitoring" {
  name        = "monitoring"
  description = "allow monitoring"
  //vpc_id      = "vpc-bae233d3"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "wordpress" {
  name        = "wordpress"
  description = "allow wordpress"
  //vpc_id      = "vpc-bae233d3"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

//data "template_file" "shell-script" {
  //template = "${file("scripts/pre.sh")}"
//}

//data "template_cloudinit_config" "cloudinit-example" {
  //gzip          = false
  //base64_encode = false

  //part {
    //content_type = "text/x-shellscript"
    //content      = "${data.template_file.shell-script.rendered}"
  //}
//}

resource "aws_instance" "ec2" {
  ami                    = "ami-6d263d09"
  instance_type          = "t2.micro"
  //user_data              = "${data.template_cloudinit_config.cloudinit-example.rendered}"
  vpc_security_group_ids = ["${aws_security_group.monitoring.id}"]
  key_name               = "key"

  tags {
    Name = "prometheus"
  }

  root_block_device {
    volume_size = "50"
  }

  provisioner "local-exec" {
  command = "sleep 100"
  }
  provisioner "local-exec" {
  command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook /home/cloud/WordPress-terraform-Docker-Prometheus/ansible/docker.yml -u ec2-user --private-key key.pem -t docker,prometheus -i ${aws_instance.ec2.public_ip},",

  }
}

resource "aws_instance" "ec2-WordPress" {
  ami                    = "ami-6d263d09"
  instance_type          = "t2.micro"
  //user_data              = "${data.template_cloudinit_config.cloudinit-example.rendered}"
  vpc_security_group_ids = ["${aws_security_group.wordpress.id}"]
  key_name               = "key"

  tags {
    Name = "WordPress"
  }

  root_block_device {
    volume_size = "50"
  }

  provisioner "local-exec" {
  command = "sleep 100"
  }
  provisioner "local-exec" {
  command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook /home/cloud/WordPress-terraform-Docker-Prometheus/ansible/docker.yml -u ec2-user --private-key key.pem -t docker,prometheus -t docker,wordpress -i ${aws_instance.ec2-WordPress.public_ip},",

  }
}
output "ip" {
  value = "${aws_instance.ec2.*.public_ip}"
}
output "ip2" {
  value = "${aws_instance.ec2-WordPress.public_ip}"
}
resource "aws_key_pair" "terraform_ec2_key" {
  key_name   = "key"
  public_key = "ssh-rsa "
}

