output "ELB DNS Name" {
    value = "${aws_elb.web-servers.dns_name}"
}
