#!/bin/bash
while getopts n:e: flag

do
    case "${flag}" in
        n) projectname=${OPTARG}
            ;;
        e) certemail=${OPTARG}
            ;;
        *) echo "Invalid option: -$flag" ;;
    esac
done

# INSTALL NODE.JS & NPM
echo "Installing Node.js and NPM..."
cd ~
sudo apt update
sudo apt install curl
curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt-get install -y nodejs

# INSTALL & CONFIGURE NGINX
echo "Installing NGINX.."
yes | sudo apt install nginx
sudo ufw allow 'Nginx HTTP'
echo "server {
    listen 80;
    listen [::]:80;

    server_name $projectname;
        
    location / {
        proxy_pass http://localhost:1337;
        include proxy_params;
    }
}" >> /etc/nginx/sites-available/$projectname
sudo ln -s /etc/nginx/sites-available/$projectname /etc/nginx/sites-enabled/
sudo systemctl restart nginx

# CERTBOT & HTTPS
echo "Configuring HTTPS..."
yes | sudo apt install snapd
yes | sudo snap install core
yes | sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
sudo ufw allow 'Nginx Full'
sudo ufw delete allow 'Nginx HTTP'
sudo certbot --nginx -d $projectname --non-interactive --agree-tos -m $certemail

# INSTALL STRAPI
echo "Installing Strapi..."
yes | npx create-strapi-app@latest $projectname --quickstart --no-run
cd $projectname
NODE_ENV=production npm run build

# INSTALL PM2 & STARTUP
echo "Installing PM2 and starting Strapi application..."
npm install pm2@latest -g
pm2 start npm --name $projectname -- run start
pm2 stop $projectname
pm2 start npm --name dev.$projectname -- run develop
pm2 save
pm2 startup
