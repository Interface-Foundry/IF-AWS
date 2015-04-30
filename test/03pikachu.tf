resource "aws_instance" "pikachu" {
  connection {
    user = "ubuntu"
    key_file = "${var.key_path}"
  }
  tags {
    Name = "pikachu"
    Webserver = "true"
  }
  ami = "${lookup(var.aws_amis, var.aws_region)}"
  key_name = "${var.key_name}"
  instance_type = "t1.micro"
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
        "sudo sh /home/ubuntu/change-hostname.sh pikachu",
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

#setup mongodb
  provisioner "file" {
    source = "scripts/install-mongodb.sh"
    destination = "/home/ubuntu/install-mongodb.sh"
  }

#setup redis
  provisioner "file" {
    source = "scripts/install-redis.sh"
    destination = "/home/ubuntu/install-redis.sh"
  }

  provisioner "file" {
    source = "scripts/redis-sentinel-upstart"
    destination = "/home/ubuntu/redis-sentinel-upstart"
  }

  provisioner "remote-exec" 
    inline = [
      "sh /home/ubuntu/install-redis.sh",
      "sudo mv /home/ubuntu/redis-sentinel-upstart /etc/init/redis-sentinel.conf",
    ]
  }

#setup log.io-server
  provisioner "file" {
    source = "scripts/install-log.io-server.sh"
    destination = "/home/ubuntu/install-log.io-server.sh"
  }

  provisioner "file" {
    source = "scripts/log.io-server-upstart"
    destination = "/home/ubuntu/log.io-server-upstart"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo bash /home/ubuntu/install-log.io-server.sh",
      "sudo mv /home/ubuntu/log.io-server-upstart /etc/init/log.io-server.conf",
    ]
  }

#configure shell
  provisioner "file" {
        source = "scripts/if_bashrc"
        destination = "/home/ubuntu/if_bashrc"
    }

  provisioner "file" {
		source = "scripts/setup_bashrc.sh"
		destination = "/home/ubuntu/setup_bashrc.sh"
    }
  
  provisioner "remote-exec" {
	inline = [
		"sh scripts/setup_bashrc.sh"
	]
  }

#reboot
  provisioner "remote-exec" {
    inline = [
        "sudo reboot",
    ]
  }

}
