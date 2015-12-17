sudo mkdir -p /data/journal
sudo mkdir -p /log
sudo mkdir -p /journal
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo chown -R ubuntu:ubuntu /data /journal /log
touch /log/mongod.log
