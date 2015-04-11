#This terraform template spins up two webserver nodes, web-server-charmander and web-server-squirtle, as well as an ELB. The webservers are in different availlability zones.

## Security Groups

The WebserverAdmin security groups allows for remote administration on ports 22 80 443 and 2997 from specific IPs. It is directly applied to the webserver instances.

The Webserver security group allows connections on ports 80 and 2997 to instances that belong to the Webserverclient security group.
This one is applied to webserver instances themselves.

The ELB is a member of the WebserverClient security group.

The WebserverPublicAccess security group allows for connection on port 80 443 from any location. This one is applied to the ELB as well.

## Instances

These webserver nodes have nginx, nodejs, pm2 and golang installed. They also have AWS's CodeDeploy agent installed to allow for easy code-deployments.

For now nginx just has the default vhost configured. Some additional configurations will be required.

Nodejs version 0.10.38 is installed from the https://deb.nodesource.com repositories.

PM2 is installed through npm.

Golang v1.4.2 is installed in /usr/local/go/ . /usr/local/go/bin has been added to the PATH.

## ELB

The Elastic Load Balancer is using an ssl certificate that was uploaded to the AWS account (see sslcerts directory). 

We have two listeners on the ELB, on ports 80 and 443. Port 80 sends traffic to port 80 on the instances, where nginx is listening (this is where a rewrite from http to https should happen).
Port 443 sends traffic back to the nodejs application listening on port 2997. SSL is offloaded by the ELB.

A healthcheck of the instances is performed on the instance by checking the following url HTTP:2997/api/healthcheck

Both webservers charmander and squirtle are members of this ELB.

## CodeDeploy

The Instances have an IAM role associated that allows them to perform Code Deployment tasks. The instances also have a tag Webserver=true which also to select which instances we want to deploy code to from the CodeDeploy webui.
The initial "application" configuration has been performed in code deploy, but it needs to be granted access to the github repository.
A small script explaining the CodeDeploy process should also be created i.e.:
```
stop the app
cleanup the folder
deploy the code
compile?
start the app
```
This can be done in a rolling fashion on the backend instances to not interrupt the services.
