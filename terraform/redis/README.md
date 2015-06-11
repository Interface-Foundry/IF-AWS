#This terraform template spins up two redis nodes, redis-thunder and redis-rainbow

## Security Groups

The Redis security groups allow connections on ports 6379 and 26379 from any instance that has the RedisClient security group applied to it.

Any instance that requires to connect to Redis should just have the RedisClient security group added to it.

Admin Access to the public ip is allowed with the AdminRedis security group on port 22.

## Instances

These instances have Redis v 2.8 installed from the default ubuntu repositories.
Because redis doesn't offer any automated discovery mechanism, the private ip addresses of these two instances needed to be static.
```
        thunder = "10.0.2.197"
        rainbow = "10.0.7.197"
```
Initially redis-thunder is the elected master.

There is a cluster monitoring daemon called redis-sentinel which is running on these nodes (as well as on the ES nodes).
The redis-sentinel daemon monitors health of the redis master server and promotes a slave to master if the master was to fail. Failover timeout is currently set  to 20secs.
A quorum of two redis-sentinel daemons is required to successfully promote a slave to master. There are 4 redis-sentinel nodes in total.

## Backups

Backups could be implemented with http://s3-backups.readthedocs.org/en/latest/
If Redis is only used to save http sessions information, this might not be necessary.
