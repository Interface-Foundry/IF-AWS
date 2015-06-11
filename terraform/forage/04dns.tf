resource "aws_route53_record" "ash" {
   zone_id = "${var.hosted_zone_id}"
   name = "forage-server-ash.kipapp.co"
   type = "A"
   ttl = "300"
   records = ["${aws_instance.forage-server-ash.public_ip}"]
}

resource "aws_route53_record" "ash-internal" {
   zone_id = "${var.hosted_zone_id}"
   name = "forage-server-ash.internal.kipapp.co"
   type = "A"
   ttl = "300"
   records = ["${aws_instance.forage-server-ash.private_ip}"]
}

