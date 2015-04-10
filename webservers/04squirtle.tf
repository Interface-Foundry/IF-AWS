resource "aws_instance" "web-server-squirtle" {
  connection {
    user = "ubuntu"
    key_file = "${var.key_path}"
  }
  tags {
    Name = "web-server-squirtle"
  }
  ami = "${lookup(var.aws_amis, var.aws_region)}"
  key_name = "${var.key_name}"
  instance_type = "${var.instance_type}"
  ebs_optimized = false
  subnet_id = "${var.subnets.subnet1_id}"
  associate_public_ip_address = "true"
  security_groups = ["${aws_security_group.WebserverAdmin.id}","${aws_security_group.Webserver.id}","${aws_security_group.WebserverClient.id}"]
  iam_instance_profile = "CodeDeploy-InstanceRole"

  #ebs_block_device {
  #    device_name = "/dev/xvdf"
  #    volume_type = "gp2"
  #    volume_size = "50"
  #    delete_on_termination = 1 }

#change hostname
  provisioner "file" {
        source = "scripts/change-hostname.sh"
        destination = "/home/ubuntu/change-hostname.sh"
    }

  provisioner "remote-exec" {
    inline = [
        "sudo sh /home/ubuntu/change-hostname.sh web-server-squirtle",
        "sudo rm /home/ubuntu/change-hostname.sh",
    ]
  }

#configure block device
#  provisioner "remote-exec" {
#    inline = [
#        "sudo mkdir -p /opt/elasticsearch",
#        "sudo mkfs.ext4 -I 512 /dev/xvdf",
#        "echo '/dev/xvdf /opt/elasticsearch ext4 defaults,noatime 1 1' | sudo tee -a /etc/fstab",
#        "sudo mount -a",
#    ]
#  }

#install and configure nginx
  provisioner "file" {
        source = "scripts/install-nginx.sh"
        destination = "/home/ubuntu/install-nginx.sh"
    }

  provisioner "remote-exec" {
    inline = [
        "sh /home/ubuntu/install-nginx.sh",
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


}
