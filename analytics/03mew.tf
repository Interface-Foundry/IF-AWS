resource "aws_instance" "analytics-db-mew" {
  connection {
    user = "ubuntu"
    key_file = "${var.key_path}"
  }
  tags {
    Name = "analytics-db-mew"
    Analytics = "true"
  }
  ami = "${lookup(var.aws_amis, var.aws_region)}"
  key_name = "${var.key_name}"
  instance_type = "${var.instance_type}"
  ebs_optimized = false
  subnet_id = "${var.subnets.subnet1_id}"
  associate_public_ip_address = "true"
  security_groups = ["${aws_security_group.AnalyticsAdmin.id}","${aws_security_group.Analytics.id}","${aws_security_group.AnalyticsClient.id}"]
  iam_instance_profile = "CodeDeploy-InstanceRole"

  ebs_block_device {
      device_name = "/dev/xvdf"
      volume_type = "gp2"
      volume_size = "5"
      encrypted = "false"
      delete_on_termination = 1 }

#change hostname
  provisioner "file" {
        source = "scripts/change-hostname.sh"
        destination = "/home/ubuntu/change-hostname.sh"
    }

  provisioner "remote-exec" {
    inline = [
        "sudo sh /home/ubuntu/change-hostname.sh analytics-db-mew",
        "sudo rm /home/ubuntu/change-hostname.sh",
    ]
  }

#install and configure mongodb
  provisioner "file" {
        source = "scripts/install-mongodb.sh"
        destination = "/home/ubuntu/install-mongodb.sh"
    }

  provisioner "remote-exec" {
    inline = [
        "sh /home/ubuntu/install-mongodb.sh",
        "sudo sed -i \"s/bind_ip = 127.0.0.1/bind_ip = ${aws_instance.analytics-db-mew.private_ip}/\" /etc/mongod.conf",
        "sudo sed -i \"s/#httpinterface = true/httpinterface = true/\" /etc/mongod.conf",
    ]
  }

#configure block device
  provisioner "remote-exec" {
    inline = [
        "sudo mkfs.ext4 -I 512 /dev/xvdf",
        "echo '/dev/xvdf /var/lib/mongodb ext4 defaults,noatime 1 1' | sudo tee -a /etc/fstab",
        "sudo mount -a",
    ]
  }

#install and configure backup job
  provisioner "file" {
        source = "scripts/install-backup_mongodb.sh"
        destination = "/home/ubuntu/install-backup_mongodb.sh"
    }

  provisioner "file" {
        source = "scripts/mongodb-snapshot"
        destination = "/home/ubuntu/mongodb-snapshot"
    }

  provisioner "file" {
        source = "scripts/mongodb-expire-snapshot"
        destination = "/home/ubuntu/mongodb-expire-snapshot"
    }

  provisioner "remote-exec" {
    inline = [
        "sh /home/ubuntu/install-backup_mongodb.sh",
        "sudo mv /home/ubuntu/mongodb-snapshot /usr/bin/",
        "sudo mv /home/ubuntu/mongodb-expire-snapshot /usr/bin/",
    ]
  }


#reboot
  provisioner "remote-exec" {
    inline = [
        "sudo reboot",
    ]
  }

}
