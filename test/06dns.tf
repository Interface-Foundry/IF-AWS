resource "aws_route53_record" "charmander" {
   zone_id = "${var.hosted_zone_id}"
   name = "web-server-charmander.kipapp.co"
   type = "A"
   ttl = "300"
   records = ["${aws_instance.web-server-charmander.public_ip}"]
}

resource "aws_route53_record" "charmander-internal" {
   zone_id = "${var.hosted_zone_id}"
   name = "web-server-charmander.internal.kipapp.co"
   type = "A"
   ttl = "300"
   records = ["${aws_instance.web-server-charmander.private_ip}"]
}

resource "aws_route53_record" "squirtle" {
   zone_id = "${var.hosted_zone_id}"
   name = "web-server-squirtle.kipapp.co"
   type = "A"
   ttl = "300"
   records = ["${aws_instance.web-server-squirtle.public_ip}"]
}

resource "aws_route53_record" "squirtle-internal" {
   zone_id = "${var.hosted_zone_id}"
   name = "web-server-squirtle.internal.kipapp.co"
   type = "A"
   ttl = "300"
   records = ["${aws_instance.web-server-squirtle.private_ip}"]
}

#alias A records are not yet supported by terraform
#resource "aws_route53_record" "ELB" {
#   zone_id = "${var.hosted_zone_id}"
#   name = "kipapp.co"
#   type = "A"
#   ttl = "300"
#   records = ["dualstack.${aws_elb.web-servers.dns_name}"]
#}

