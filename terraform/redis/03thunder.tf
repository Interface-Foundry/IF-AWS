resource "aws_instance" "redis-thunder" {
  connection {
    user = "ubuntu"
    key_file = "${var.key_path}"
  }
  tags {
    Name = "redis-thunder"
    Redis = "true"
  }
  ami = "${lookup(var.aws_amis, var.aws_region)}"
  key_name = "${var.key_name}"
  instance_type = "${var.instance_type}"
  ebs_optimized = false
  subnet_id = "${var.subnets.subnet1_id}"
  associate_public_ip_address = "true"
  security_groups = ["${aws_security_group.RedisAdmin.id}","${aws_security_group.Redis.id}","${aws_security_group.RedisClient.id}"]
  private_ip = "${var.private_ip.thunder}"

#change hostname
  provisioner "file" {
        source = "scripts/change-hostname.sh"
        destination = "/home/ubuntu/change-hostname.sh"
    }

  provisioner "remote-exec" {
    inline = [
        "sudo sh /home/ubuntu/change-hostname.sh redis-thunder",
        "sudo rm /home/ubuntu/change-hostname.sh",
    ]
  }

#install and configure redis
  provisioner "file" {
        source = "scripts/install-redis.sh"
        destination = "/home/ubuntu/install-redis.sh"
    }

  provisioner "file" {
        source = "scripts/redis-sentinel-upstart"
        destination = "/home/ubuntu/redis-sentinel-upstart"
    }

  provisioner "remote-exec" {
    inline = [
        "sh /home/ubuntu/install-redis.sh",
        "sudo mv /home/ubuntu/redis-sentinel-upstart /etc/init/redis-sentinel.conf",
    ]
  }

  provisioner "remote-exec" {
    inline = [
        "sudo sed -i \"s/bind 127.0.0.1/bind ${aws_instance.redis-thunder.private_ip}/\" /etc/redis/redis.conf",
        "sudo mv /etc/redis/sentinel.conf /etc/redis/sentinel.conf.orig",
        "echo sentinel monitor mymaster ${aws_instance.redis-thunder.private_ip} 6379 2 | sudo tee /etc/redis/sentinel.conf",
        "echo sentinel down-after-milliseconds mymaster 20000 | sudo tee -a /etc/redis/sentinel.conf",
        "echo sentinel failover-timeout mymaster 30000 | sudo tee -a /etc/redis/sentinel.conf",
        "echo sentinel parallel-syncs mymaster 1 | sudo tee -a /etc/redis/sentinel.conf",
    ]
  }

  provisioner "remote-exec" {
    inline = [
        "echo vm.overcommit_memory = 1 | sudo tee -a /etc/sysctl.conf",
        "sudo reboot",
    ]
  }

}
