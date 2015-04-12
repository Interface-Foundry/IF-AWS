resource "aws_instance" "forage-server-ash" {
  connection {
    user = "ubuntu"
    key_file = "${var.key_path}"
  }
  tags {
    Name = "forage-server-ash"
    Forageserver = "true"
  }
  ami = "${lookup(var.aws_amis, var.aws_region)}"
  key_name = "${var.key_name}"
  instance_type = "${var.instance_type}"
  ebs_optimized = false
  subnet_id = "${var.subnets.subnet1_id}"
  associate_public_ip_address = "true"
  security_groups = ["${aws_security_group.ForageAdmin.id}","${aws_security_group.Forage.id}","${aws_security_group.ForageClient.id}"]
  iam_instance_profile = "CodeDeploy-InstanceRole"

#change hostname
  provisioner "file" {
        source = "scripts/change-hostname.sh"
        destination = "/home/ubuntu/change-hostname.sh"
    }

  provisioner "remote-exec" {
    inline = [
        "sudo sh /home/ubuntu/change-hostname.sh forage-server-ash",
        "sudo rm /home/ubuntu/change-hostname.sh",
    ]
  }

#install and configure nginx
#  provisioner "file" {
#        source = "scripts/install-nginx.sh"
#        destination = "/home/ubuntu/install-nginx.sh"
#    }

#  provisioner "remote-exec" {
#    inline = [
#        "sh /home/ubuntu/install-nginx.sh",
#    ]
#  }

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
#  provisioner "file" {
#        source = "scripts/install-golang.sh"
#        destination = "/home/ubuntu/install-golang.sh"
#    }

#  provisioner "remote-exec" {
#    inline = [
#        "sh /home/ubuntu/install-golang.sh",
#    ]
#  }


}
