resource "aws_security_group" "TestServer" {
    name = "TestServer"
    description = "Test server"
    vpc_id = "${var.vpc_id}"

#peter's home - 73.39.200.49
#pierig's home - 99.241.92.210
#pythian vpn - 209.217.100.73
#Interface Foundry - 198.176.46.33 
#Jumpbox at DigitalOcean for JR's ipv6 limitation - 104.236.113.206

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["99.241.92.210/32","73.39.200.49/32","209.217.100.73/32","198.176.46.33/32","104.236.113.206/32"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0","99.241.92.210/32","73.39.200.49/32","209.217.100.73/32","198.176.46.33/32"]
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0","99.241.92.210/32","73.39.200.49/32","209.217.100.73/32","198.176.46.33/32"]
    }

    ingress {
        from_port = 2997
        to_port = 2997
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0","99.241.92.210/32","73.39.200.49/32","209.217.100.73/32","198.176.46.33/32"]
    }

    ingress {
        from_port = 28778
        to_port = 28778
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0","99.241.92.210/32","73.39.200.49/32","209.217.100.73/32","198.176.46.33/32"]
    }


    ingress {
        from_port = 9090
        to_port = 9090
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0","99.241.92.210/32","73.39.200.49/32","209.217.100.73/32","198.176.46.33/32"]
    }


    ingress {
        from_port = 9200
        to_port = 9200
        protocol = "tcp"
        cidr_blocks = ["99.241.92.210/32","73.39.200.49/32","209.217.100.73/32","198.176.46.33/32"]
    }

}
