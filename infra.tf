variable "access_key" {}
variable "secret_key" {}
variable "private_key" {}
variable "key_name" {}

provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "us-east-1"
}
resource "aws_security_group" "default" {
    name = "h default"
    description = "Default group, ssh access"

    # SSH access from anywhere
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "frontend" {
    name = "h frontend"
    description = "Allow port 80 to fe"

    # HTTP access from anywhere
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "fe01" {
    ami = "ami-408c7f28"
    instance_type = "t1.micro"
    security_groups = ["default", "${aws_security_group.default.name}", "${aws_security_group.frontend.name}"]
    key_name = "${var.key_name}"

    connection {
        user = "ubuntu"
        type = "ssh"
        key_file = "${var.private_key}"
        timeout = "2m"
    }
    provisioner "remote-exec" {
        inline = [
            "sudo apt-get -y update",
        ]
    }
}
resource "aws_instance" "app01" {
    ami = "ami-408c7f28"
    instance_type = "t1.micro"
    security_groups = ["default", "${aws_security_group.default.name}"]
    key_name = "${var.key_name}"

    connection {
        user = "ubuntu"
        type = "ssh"
        key_file = "${var.private_key}"
        timeout = "2m"
    }
    provisioner "remote-exec" {
        inline = [
            "sudo apt-get -y update",
        ]
    }
}

resource "aws_instance" "app02" {
    ami = "ami-408c7f28"
    instance_type = "t1.micro"
    security_groups = ["default", "${aws_security_group.default.name}"]
    key_name = "${var.key_name}"

    connection {
        user = "ubuntu"
        type = "ssh"
        key_file = "${var.private_key}"
        timeout = "2m"
    }
    provisioner "remote-exec" {
        inline = [
            "sudo apt-get -y update",
        ]
    }
}

resource "aws_instance" "monitoring01" {
    ami = "ami-408c7f28"
    instance_type = "t1.micro"
    security_groups = ["default", "${aws_security_group.default.name}", "${aws_security_group.frontend.name}"]
    key_name = "${var.key_name}"

    connection {
        user = "ubuntu"
        type = "ssh"
        key_file = "${var.private_key}"
        timeout = "2m"
    }
    provisioner "remote-exec" {
        inline = [
            "sudo apt-get -y update",
        ]
    }
}
