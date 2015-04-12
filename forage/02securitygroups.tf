resource "aws_security_group" "ForageAdmin" {
    name = "ForageAdmin"
    description = "Forage Admin Access"
    vpc_id = "${var.vpc_id}"

#peter's home - 98.204.55.178
#pierig's home - 99.241.92.210
#pythian vpn - 209.217.100.73
#Interface Foundry - 198.176.46.33 

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["99.241.92.210/32","98.204.55.178/32","209.217.100.73/32","198.176.46.33/32"]
    }

}

resource "aws_security_group" "ForageClient" {
    name = "ForageClient"
    description = "EC2 instances in this SG can connect to the Forage server on select ports selected in the Forage security group"
    vpc_id = "${var.vpc_id}"

}

resource "aws_security_group" "Forage" {
    name = "Forage"
    description = "EC2 instances in ForageClient can connect to the Forage server on these ports"
    vpc_id = "${var.vpc_id}"

    ingress {
        from_port = 999
        to_port = 999
        protocol = "tcp"
        security_groups = ["${aws_security_group.ForageClient.id}"]
    }

}
