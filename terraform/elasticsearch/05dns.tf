resource "aws_route53_record" "vermillion" {
   zone_id = "${var.hosted_zone_id}"
   name = "elasticsearch-vermillion.kipapp.co"
   type = "A"
   ttl = "300"
   records = ["${aws_instance.elasticsearch-vermillion.public_ip}"]
}

resource "aws_route53_record" "vermillion-internal" {
   zone_id = "${var.hosted_zone_id}"
   name = "elasticsearch-vermillion.internal.kipapp.co"
   type = "A"
   ttl = "300"
   records = ["${aws_instance.elasticsearch-vermillion.private_ip}"]
}

resource "aws_route53_record" "cerulean" {
   zone_id = "${var.hosted_zone_id}"
   name = "elasticsearch-cerulean.kipapp.co"
   type = "A"
   ttl = "300"
   records = ["${aws_instance.elasticsearch-cerulean.public_ip}"]
}

resource "aws_route53_record" "cerulean-internal" {
   zone_id = "${var.hosted_zone_id}"
   name = "elasticsearch-cerulean.internal.kipapp.co"
   type = "A"
   ttl = "300"
   records = ["${aws_instance.elasticsearch-cerulean.private_ip}"]
}
