resource "aws_elb" "web-servers" {
  name = "web-servers"
  subnets = ["${var.subnets.subnet1_id}", "${var.subnets.subnet2_id}", "${var.subnets.subnet3_id}"]
  security_groups = ["${aws_security_group.WebserverClient.id}","${aws_security_group.WebserverPublicAccess.id}"]
  

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  listener {
    instance_port = 443
    instance_protocol = "https"
    lb_port = 443
    lb_protocol = "https"
    ssl_certificate_id = "arn:aws:iam::127521922525:server-certificate/kipapp-co"
  }

#  health_check {
#    healthy_threshold = 2
#    unhealthy_threshold = 2
#    timeout = 3
#    target = "HTTP:2997/api/healthcheck"
#    interval = 10
#  }

  instances = ["${aws_instance.web-server-charmander.id}","${aws_instance.web-server-squirtle.id}"]
  cross_zone_load_balancing = true

}
