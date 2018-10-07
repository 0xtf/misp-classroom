provider "aws" {
  profile    = "default"
  region     = "eu-west-1"
}

#######################################################
#           Creation of ephemeral SSH key             #
#######################################################

resource "tls_private_key" "bootstrap_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

#######################################################
#           Creation of AWS Keypair resource          #
#######################################################

resource "aws_key_pair" "bootstrap_generated_key" {
  key_name   = "misp-ssh-classroom"
  public_key = "${tls_private_key.bootstrap_private_key.public_key_openssh}"
}

#######################################################
#          Firewall SG rules creation                 #
#######################################################

resource "aws_security_group" "misp_classroom" {
  name        = "MISP Classroom HTTPS"
  description = "SG for MISP Classroom via HTTPS"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    Name = "MISP Classrom HTTPS"
  }
}

#######################################################
#  Creation of SSH SG access - Only used for debug    #
#######################################################

resource "aws_security_group" "misp_classroom_ssh" {
  name        = "MISP Classroom SSH"
  description = "SG for MISP Classroom via SSH"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    Name = "MISP Classrom SSH"
  }
}

#######################################################
#      Instance creation with a count                                = "2"
#######################################################

resource "aws_instance" "misp-classrom" {
  count                                = "2"
  ami                                  = "${data.aws_ami.misp-build.id}"
  instance_type                        = "t2.micro"
  instance_initiated_shutdown_behavior = "terminate"
  key_name      		       = "misp-ssh-classroom"
  security_groups                      = ["${aws_security_group.misp_classroom.name}","${aws_security_group.misp_classroom_ssh.name}"]

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${tls_private_key.bootstrap_private_key.private_key_pem}"
  }
    inline = [
      "sudo shutdown -P +5 > /dev/null",
    ]
  }

  tags { 
    Name = "misp-classroom-${count.index+1}"
  }

  depends_on = ["aws_security_group.misp_classroom"]
}

#######################################################
#      Use the lastest version of MISP-Cloud          #
#######################################################

data "aws_ami" "misp-build" {
  filter {
    name   = "state"
    values = ["available"]
  }

  owners = ["206040430303"]
  most_recent = true
}

#######################################################
#      Provide IP list of created instances           #
#######################################################

output "ip" {
  value = ["${aws_instance.misp-classrom.*.public_ip}"] 
}

#######################################################
#  Provide SSH Private key to instructor for debug    #
#######################################################

output "private_key" {
  value = ["${tls_private_key.bootstrap_private_key.private_key_pem}"]
}
