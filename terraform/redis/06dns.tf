resource "aws_route53_record" "thunder" {
   zone_id = "${var.hosted_zone_id}"
   name = "redis-thunder.kipapp.co"
   type = "A"
   ttl = "300"
   records = ["${aws_instance.redis-thunder.public_ip}"]
}

resource "aws_route53_record" "thunder-internal" {
   zone_id = "${var.hosted_zone_id}"
   name = "redis-thunder.internal.kipapp.co"
   type = "A"
   ttl = "300"
   records = ["${aws_instance.redis-thunder.private_ip}"]
}

resource "aws_route53_record" "rainbow" {
   zone_id = "${var.hosted_zone_id}"
   name = "redis-rainbow.kipapp.co"
   type = "A"
   ttl = "300"
   records = ["${aws_instance.redis-rainbow.public_ip}"]
}

resource "aws_route53_record" "rainbow-internal" {
   zone_id = "${var.hosted_zone_id}"
   name = "redis-rainbow.internal.kipapp.co"
   type = "A"
   ttl = "300"
   records = ["${aws_instance.redis-rainbow.private_ip}"]
}

