#This terraform template spins up two elasticsearch nodes, elasticsearch-vermillion and elasticsearch-cerulean

## Security Groups

The Elasticsearch security groups allow connections on ports 9200 and 9300 from any instance that has the ElasticsearchClient security group applied to it.

Any instance that requires to connect to ES should just have the ElasticsearchClient security group added to it.

Admin Access to the public ip is allowed with the AdminElasticsearch security group on ports 22 and 9200.

## Instances

This instance has an additional 50G block device mounted in the /opt/elasticsearch directory. This directory holds ES data.

The two instances have the elasticsearch v1.4 repository (current ES version is 1.4.4) added as well as the following plugins:

elasticsearch/elasticsearch-cloud-aws/2.4.1

mobz/elasticsearch-head

lukas-vlcek/bigdesk

com.github.richardwilly98.elasticsearch/elasticsearch-river-mongodb/2.0.9

The elasticsearch-cloud-aws plugin allows to automatically setup the cluster based on EC2 tags.
Each instance has an IAM policy attached to it which allows it to run ec2-describe command within the AWS account.
It this then configured to search for the Elasticsearch=true tag to discover other nodes.

Note that the elasticsearch nodes also have redis installed. This is just to run the cluster monitoring daemon called redis sentinel. Redis-server is not running on these nodes.
The redis-sentinel daemon monitors health of the redis master server and promotes a slave to master if the master was to fail. Failover timeout is currently set  to 20secs.
