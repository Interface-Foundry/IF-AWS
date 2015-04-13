variable "key_name" {
    description = "Name of the SSH keypair to use in AWS."
}

variable "key_path" {
    description = "Path to the private portion of the SSH key specified."
}

variable "access_key" {
    description = "you AWS access key"
}

variable "secret_key" {
    description = "you AWS secret key"
}

variable "aws_region" {
    description = "AWS region to launch servers."
    default = "us-east-1"
}

variable "vpc_id" {
    description = "AWS VPC Id"
    default = "vpc-8287d9e7"
}

# Ubuntu Server 14.04 LTS (HVM), SSD Volume Type
variable "aws_amis" {
    default = {
        us-east-1 = "ami-d05e75b8"
    }

}
variable "instance_type" {
    description = "EC2 Instance type"
    default = "t2.medium"
}

variable "zones" {
    description = "availlability zones"
    default = {
        zone1 = "us-east-1a"
        zone2 = "us-east-1b"
        zone3 = "us-east-1d"
    }
}

variable "subnets" {
    description = "ID of glusterfs nodes Subnets"
    default = {
        subnet1_id = "subnet-376c0740"
        subnet2_id = "subnet-c4f9709d"
        subnet3_id = "subnet-326fde19"
    }
}

variable "private_ip" {
    description = "ID of redis nodes"
    default = {
        thunder = "10.0.2.197"
        rainbow = "10.0.7.197"
    }
}

variable "security_groups" {
    description = "some security groups"
    default = {
        RedisClient = "sg-ca7d02ae"
        Redis       = "sg-ce7d02aa"
        ElasticsearchClient = "sg-c07c03a4"
    }
}

variable "hosted_zone_id" {
    description = "Route53 Public zone Id"
    default = "Z3JM27F7IBJE9W"
}
