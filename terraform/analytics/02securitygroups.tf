resource "aws_security_group" "AnalyticsAdmin" {
    name = "AnalyticsAdmin"
    description = "Analytics Admin Access"
    vpc_id = "${var.vpc_id}"

#peter's home - 73.39.200.49
#pierig's home - 99.241.92.210
#pythian vpn - 209.217.100.73
#Interface Foundry - 198.176.46.33 

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["99.241.92.210/32","73.39.200.49/32","209.217.100.73/32","198.176.46.33/32"]
    }

    ingress {
        from_port = 28017
        to_port = 28017
        protocol = "tcp"
        cidr_blocks = ["99.241.92.210/32","73.39.200.49/32","209.217.100.73/32","198.176.46.33/32"]
    }

}

resource "aws_security_group" "AnalyticsClient" {
    name = "AnalyticsClient"
    description = "EC2 instances in this SG can connect to the Analytics server on select ports selected in the Analytics security group"
    vpc_id = "${var.vpc_id}"

}

resource "aws_security_group" "Analytics" {
    name = "Analytics"
    description = "EC2 instances in AnalyticsClient can connect to the Analytics server on these ports"
    vpc_id = "${var.vpc_id}"

    ingress {
        from_port = 27017
        to_port = 27017
        protocol = "tcp"
        security_groups = ["${aws_security_group.AnalyticsClient.id}"]
    }

    ingress {
        from_port = 28017
        to_port = 28017
        protocol = "tcp"
        security_groups = ["${aws_security_group.AnalyticsClient.id}"]
    }

}
