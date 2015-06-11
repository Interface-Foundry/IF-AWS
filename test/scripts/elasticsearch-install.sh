sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install openjdk-7-jre-headless -y
wget -qO - https://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
sudo add-apt-repository "deb http://packages.elasticsearch.org/elasticsearch/1.4/debian stable main"
sudo apt-get update && sudo apt-get install elasticsearch -y
sudo update-rc.d elasticsearch defaults 95 10
sudo /usr/share/elasticsearch/bin/plugin install elasticsearch/elasticsearch-cloud-aws/2.4.1
sudo /usr/share/elasticsearch/bin/plugin install mobz/elasticsearch-head
sudo /usr/share/elasticsearch/bin/plugin install lukas-vlcek/bigdesk
sudo /usr/share/elasticsearch/bin/plugin install com.github.richardwilly98.elasticsearch/elasticsearch-river-mongodb/2.0.9
sudo chown elasticsearch:elasticsearch /db/elasticsearch
