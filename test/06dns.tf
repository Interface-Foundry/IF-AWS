resource "aws_route53_record" "pikachu" {
   zone_id = "${var.hosted_zone_id}"
   name = "pikachu.kipapp.co"
   type = "A"
   ttl = "300"
   records = ["${aws_instance.pikachu.public_ip}"]
}

resource "aws_route53_record" "pikachu-internal" {
   zone_id = "${var.hosted_zone_id}"
   name = "pikachu.internal.kipapp.co"
   type = "A"
   ttl = "300"
   records = ["${aws_instance.pikachu.private_ip}"]
}

