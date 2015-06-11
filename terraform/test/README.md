#This terraform template spins up the test server, pikachu, as well as an ELB.

## Security Groups

The WebserverAdmin security groups allows for remote administration on ports 22 80 443 and 2997 from specific IPs. It is directly applied to the webserver instances.

The Webserver security group allows connections on ports 80 and 2997 to instances that belong to the Webserverclient security group.
This one is applied to webserver instances themselves.

The ELB is a member of the WebserverClient security group.

The WebserverPublicAccess security group allows for connection on port 80 443 from any location. This one is applied to the ELB as well.

## Instances

This server has everything.  Node, nginx, golang, pm2, elasticsearch, redis, mongodb, log.io

These webserver nodes have nginx, nodejs, pm2 and golang installed. They also have AWS's CodeDeploy agent installed to allow for easy code-deployments.

Nginx listens on port 80 and 443. Port 80 rewrites http traffic to https.

On port 443 the ssl certificates have been configured. A proxy_pass to the backend application on 127.0.0.1:2997 has been implemented.

Nodejs version 0.10.38 is installed from the https://deb.nodesource.com repositories.

PM2 is installed through npm.

Golang v1.4.2 is installed in /usr/local/go/ . /usr/local/go/bin has been added to the PATH.

## ELB

The Elastic Load Balancer is using an ssl certificate that was uploaded to the AWS account (see sslcerts directory). 

We have two listeners on the ELB, on ports 80 and 443. Port 80 sends traffic to port 80 on the instances, where nginx is listening - traffic is rewritten to https useing the $server parameter.
This permits the rewrite to work when directly accessing the nodes without going through the ELB. The ssl certificate will appear invalid in this case, as it's not a wildcard cert.
Port 443 sends traffic back to nginx through http on port 443. SSL is offloaded by the ELB, but communication between the ELB and nginx are secured as well.

A healthcheck of the instances is performed on the instance by checking the following url HTTP:2997/api/healthcheck (to be enabled once the app is deployed)

Both webservers charmander and squirtle are members of this ELB.

## CodeDeploy

The Instances have an IAM role associated that allows them to perform Code Deployment tasks. The instances also have a tag Webserver=true which also to select which instances we want to deploy code to from the CodeDeploy webui.
Thde deployment can be done in a rolling fashion on the backend instances to not interrupt the services.

In the IF-root directory, the appspec.yml file describes the actual deployment process, while several scripts that help with the deployment are held in the codedeploy-scripts directory.

## Application
An application user has been created. Username is kip. Home directory of this user is /opt/kipp. The application is desployed in the /opt/kip/App directory.
