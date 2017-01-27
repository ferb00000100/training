#
# DO NOT DELETE THESE LINES!
#
# Your subnet ID is:
#
#     subnet-ddd57685
#
# Your security group ID is:
#
#     sg-29ef374e
#
# Your AMI ID is:
#
#     ami-30217250
#
# Your Identity is:
#
#     autodesk-buffalo
#

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_region" {
  default = "us-west-1"
}

variable "num_webs" {
  default = "1"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  # count                  = "2"
  count                  = "${var.num_webs}"
  instance_type          = "t2.micro"
  ami                    = "ami-30217250"
  subnet_id              = "subnet-ddd57685"
  vpc_security_group_ids = ["sg-29ef374e"]

  tags {
    Identity = "autodesk-buffalos"
    Name     = "MyWeb Server"
    Service  = "webapp"
    MyName   = "web ${count.index+1}/${var.num_webs}"
  }
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}
