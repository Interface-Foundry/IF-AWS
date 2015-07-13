#!/bin/bash

echo installing docker on this computer
wget -qO- https://get.docker.com/ | sh
echo 'DOCKER_OPTS="--insecure-registry pikachu.kipapp.co:5000"' | sudo tee -a /etc/default/docker
