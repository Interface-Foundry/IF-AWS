sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install nginx -y
sudo mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.orig

cat <<'EOF' >> default
server {
       listen         80 default_server;
       listen [::]:80 default_server ipv6only=on;
       server_name    kipapp.co;
	   client_max_body_size 50m;
       return         301 https://$host$request_uri;
}
server {
       listen 443;
       listen [::]:443 ipv6only=on;
       server_name    kipapp.co;
	   client_max_body_size 50m;

       ssl on;
       ssl_certificate     /etc/ssl/kipapp-co.pem;
       ssl_certificate_key /etc/ssl/kipapp-co.key;


       location / {
        proxy_pass http://127.0.0.1:2997;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        }
}
EOF

sudo mv /home/ubuntu/default /etc/nginx/sites-available/default
