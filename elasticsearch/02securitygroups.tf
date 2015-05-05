resource "aws_security_group" "ElasticsearchAdmin" {
    name = "ElasticsearchAdmin"
    description = "Elasticsearch Admin Access"
    vpc_id = "${var.vpc_id}"

#peter's home - 98.204.55.178
#pierig's home - 99.241.92.210
#pythian vpn - 209.217.100.73
#if - 198.176.46.33

    ingress {
        from_port = 9200
        to_port = 9200
        protocol = "tcp"
        cidr_blocks = ["99.241.92.210/32","98.204.55.178/32","209.217.100.73/32","198.176.46.33"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["99.241.92.210/32","98.204.55.178/32","209.217.100.73/32","198.176.46.33"]
    }
}

resource "aws_security_group" "ElasticsearchClient" {
    name = "ElasticsearchClient"
    description = "EC2 instances in this SG can be Elasticsearch clients"
    vpc_id = "${var.vpc_id}"

}

resource "aws_security_group" "Elasticsearch" {
    name = "Elasticsearch"
    description = "EC2 instances in ElasticsearchClient can be Elasticsearch clients"
    vpc_id = "${var.vpc_id}"

    ingress {
        from_port = 9300
        to_port = 9300
        protocol = "tcp"
        security_groups = ["${aws_security_group.ElasticsearchClient.id}"]
    }

    ingress {
        from_port = 9200
        to_port = 9200
        protocol = "tcp"
        security_groups = ["${aws_security_group.ElasticsearchClient.id}"]
    }

}
