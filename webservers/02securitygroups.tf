resource "aws_security_group" "WebserverAdmin" {
    name = "WebserverAdmin"
    description = "Webserver Admin Access"
    vpc_id = "${var.vpc_id}"

#peter's home - 98.204.55.178
#pierig's home - 99.241.92.210
#pythian vpn - 209.217.100.73

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["99.241.92.210/32","98.204.55.178/32","209.217.100.73/32"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["99.241.92.210/32","98.204.55.178/32","209.217.100.73/32"]
    }

    ingress {
        from_port = 2997
        to_port = 2997
        protocol = "tcp"
        cidr_blocks = ["99.241.92.210/32","98.204.55.178/32","209.217.100.73/32"]
    }

}

resource "aws_security_group" "WebserverClient" {
    name = "WebserverClient"
    description = "EC2 instances in this SG can connect to the webservers"
    vpc_id = "${var.vpc_id}"

}

resource "aws_security_group" "Webserver" {
    name = "Webserver"
    description = "EC2 instances in WebserverClient can connect to the webservers"
    vpc_id = "${var.vpc_id}"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = ["${aws_security_group.WebserverClient.id}"]
    }

    ingress {
        from_port = 2997
        to_port = 2997
        protocol = "tcp"
        security_groups = ["${aws_security_group.WebserverClient.id}"]
    }

}

resource "aws_security_group" "WebserverPublicAccess" {
    name = "WebserverPublicAccess"
    description = "Webserver Public Access"
    vpc_id = "${var.vpc_id}"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}