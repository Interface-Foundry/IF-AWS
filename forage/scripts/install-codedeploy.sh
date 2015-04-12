#!/bin/bash
sudo apt-get -y install awscli ruby2.0
mkdir /home/ubuntu/codedeploy_install
cd /home/ubuntu/codedeploy_install
aws s3 cp s3://aws-codedeploy-us-east-1/latest/install . --region us-east-1
sleep 30
chmod +x ./install
sudo ./install auto
