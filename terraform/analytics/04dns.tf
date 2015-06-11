resource "aws_route53_record" "mew" {
   zone_id = "${var.hosted_zone_id}"
   name = "analytics-db-mew.kipapp.co"
   type = "A"
   ttl = "300"
   records = ["${aws_instance.analytics-db-mew.public_ip}"]
}

resource "aws_route53_record" "mew-internal" {
   zone_id = "${var.hosted_zone_id}"
   name = "analytics-db-mew.internal.kipapp.co"
   type = "A"
   ttl = "300"
   records = ["${aws_instance.analytics-db-mew.private_ip}"]
}
