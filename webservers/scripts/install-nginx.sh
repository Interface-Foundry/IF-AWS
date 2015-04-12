sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install nginx -y
sudo mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.orig

cat <<'EOF' >> default
server {
       listen         80 default_server;
       listen [::]:80 default_server ipv6only=on;
       server_name    kipapp.co;
       return         301 https://$host$request_uri;
}
server {
       listen 443;
       listen [::]:443 ipv6only=on;
       server_name    kipapp.co;

       ssl on;
       ssl_certificate     /etc/ssl/kipapp-co.pem;
       ssl_certificate_key /etc/ssl/kipapp-co.key;

       root /usr/share/nginx/html;
       index index.html index.htm;

       location / {
                # First attempt to serve request as file, then
                # as directory, then fall back to displaying a 404.
                try_files $uri $uri/ =404;
                # Uncomment to enable naxsi on this location
                # include /etc/nginx/naxsi.rules
        }
}
EOF

sudo mv /home/ubuntu/default /etc/nginx/sites-available/default
