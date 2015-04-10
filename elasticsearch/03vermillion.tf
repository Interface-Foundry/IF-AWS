resource "aws_instance" "elasticsearch-vermillion" {
  connection {
    user = "ubuntu"
    key_file = "${var.key_path}"
  }
  tags {
    Name = "elasticsearch-vermillion"
    Elasticsearch = "true"
  }
  ami = "${lookup(var.aws_amis, var.aws_region)}"
  key_name = "${var.key_name}"
  instance_type = "${var.instance_type}"
  ebs_optimized = false
  subnet_id = "${var.subnets.subnet1_id}"
  associate_public_ip_address = "true"
  security_groups = ["${aws_security_group.ElasticsearchAdmin.id}","${aws_security_group.Elasticsearch.id}","${aws_security_group.ElasticsearchClient.id}"]
  iam_instance_profile = "ElasticsearchDiscovery" 

  ebs_block_device {
      device_name = "/dev/xvdf"
      volume_type = "gp2"
      volume_size = "50"
      delete_on_termination = 1 }

#change hostname
  provisioner "file" {
        source = "scripts/change-hostname.sh"
        destination = "/home/ubuntu/change-hostname.sh"
    }

  provisioner "remote-exec" {
    inline = [
        "sudo sh /home/ubuntu/change-hostname.sh elasticsearch-vermillion",
        "sudo rm /home/ubuntu/change-hostname.sh",
    ]
  }

#configure block device
  provisioner "remote-exec" {
    inline = [
        "sudo mkdir -p /opt/elasticsearch",
        "sudo mkfs.ext4 -I 512 /dev/xvdf",
        "echo '/dev/xvdf /opt/elasticsearch ext4 defaults,noatime 1 1' | sudo tee -a /etc/fstab",
        "sudo mount -a",
    ]
  }

#install and configure elasticsearch
  provisioner "file" {
        source = "scripts/elasticsearch-install.sh"
        destination = "/home/ubuntu/elasticsearch-install.sh"
    }

  provisioner "remote-exec" {
    inline = [
        "sh /home/ubuntu/elasticsearch-install.sh",
    ]
  }

  provisioner "file" {
        source = "scripts/elasticsearch-vermillion.yml"
        destination = "/home/ubuntu/elasticsearch.yml"
    }

  provisioner "remote-exec" {
    inline = [
        "sudo mv /etc/elasticsearch/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml.orig",
        "sudo mv /home/ubuntu/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml",
        "sudo service elasticsearch start",
    ]
  }

}
