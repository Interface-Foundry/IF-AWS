resource "aws_instance" "web-server-charmander" {
  connection {
    user = "ubuntu"
    key_file = "${var.key_path}"
  }
  tags {
    Name = "web-server-charmander"
    Webserver = "true"
  }
  ami = "${lookup(var.aws_amis, var.aws_region)}"
  key_name = "${var.key_name}"
  instance_type = "c4.xlarge"
  ebs_optimized = false
  subnet_id = "${var.subnets.subnet1_id}"
  associate_public_ip_address = "true"
  security_groups = ["${aws_security_group.WebserverAdmin.id}","${aws_security_group.Webserver.id}","${aws_security_group.WebserverClient.id}","${var.security_groups.RedisClient}","${var.security_groups.ElasticsearchClient}"]
  iam_instance_profile = "CodeDeploy-InstanceRole"

#change hostname
  provisioner "file" {
        source = "scripts/change-hostname.sh"
        destination = "/home/ubuntu/change-hostname.sh"
    }

  provisioner "remote-exec" {
    inline = [
        "sudo sh /home/ubuntu/change-hostname.sh web-server-charmander",
        "sudo rm /home/ubuntu/change-hostname.sh",
    ]
  }

#install and configure nginx
  provisioner "file" {
        source = "scripts/install-nginx.sh"
        destination = "/home/ubuntu/install-nginx.sh"
    }

  provisioner "file" {
        source = "../sslcerts/nginx-kipapp-co.pem"
        destination = "/home/ubuntu/kipapp-co.pem"
    }

  provisioner "file" {
        source = "../sslcerts/kipapp-co.key"
        destination = "/home/ubuntu/kipapp-co.key"
    }

  provisioner "remote-exec" {
    inline = [
        "sh /home/ubuntu/install-nginx.sh",
        "sudo mv /home/ubuntu/kipapp-co.pem /etc/ssl/",
        "sudo mv /home/ubuntu/kipapp-co.key /etc/ssl/",
    ]
  }

#install and configure nodejs
  provisioner "file" {
        source = "scripts/install-nodejs.sh"
        destination = "/home/ubuntu/install-nodejs.sh"
    }

  provisioner "remote-exec" {
    inline = [
        "sh /home/ubuntu/install-nodejs.sh",
    ]
  }

#install and configure codedeploy
  provisioner "file" {
        source = "scripts/install-codedeploy.sh"
        destination = "/home/ubuntu/install-codedeploy.sh"
    }

  provisioner "remote-exec" {
    inline = [
        "sh /home/ubuntu/install-codedeploy.sh",
    ]
  }

#install and configure golang
  provisioner "file" {
        source = "scripts/install-golang.sh"
        destination = "/home/ubuntu/install-golang.sh"
    }

  provisioner "remote-exec" {
    inline = [
        "sh /home/ubuntu/install-golang.sh",
    ]
  }

#reboot
  provisioner "remote-exec" {
    inline = [
        "sudo reboot",
    ]
  }

}
