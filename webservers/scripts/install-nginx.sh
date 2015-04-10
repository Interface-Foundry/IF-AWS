sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install nginx -y
sudo mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.orig

cat <<'EOF' >> default
server {
       listen         80;
       server_name    kipapp.co;
       return         301 https://$server_name$request_uri;
}
EOF

sudo mv /home/ubuntu/default /etc/nginx/sites-available/default
sudo service nginx restart
