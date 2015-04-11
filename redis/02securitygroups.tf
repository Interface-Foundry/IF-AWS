resource "aws_security_group" "RedisAdmin" {
    name = "RedisAdmin"
    description = "Redis Admin Access"
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

}

resource "aws_security_group" "RedisClient" {
    name = "RedisClient"
    description = "EC2 instances in this SG can connect to the Redis"
    vpc_id = "${var.vpc_id}"

}

resource "aws_security_group" "Redis" {
    name = "Redis"
    description = "EC2 instances in RedisClient can connect to the Redis"
    vpc_id = "${var.vpc_id}"

    ingress {
        from_port = 6379
        to_port = 6379
        protocol = "tcp"
        security_groups = ["${aws_security_group.RedisClient.id}"]
    }

    ingress {
        from_port = 26379
        to_port = 26379
        protocol = "tcp"
        security_groups = ["${aws_security_group.RedisClient.id}"]
    }

}

