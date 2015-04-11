sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install redis-server -y
sudo update-rc.d redis-server defaults 95 10
