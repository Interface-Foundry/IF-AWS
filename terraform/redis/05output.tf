output "RedisClient security group id" {
    value = "You will need to adjust this variable in the elasticsearch template variables ${aws_security_group.RedisClient.id}"
}

output "Redis security group id" {
    value = "You will need to adjust this variable in the elasticsearch template variables ${aws_security_group.Redis.id}"
}
