
#For SSH
ssh -i /Users/numan/Downloads/numan-cloud.pem ubuntu@52.203.70.114

#For Scp
scp -i /Users/numan/Downloads/numan-cloud.pem -r /Users/numan/numan/projects/web/Numan-Portfolio/* ubuntu@52.203.70.114:/home/ubuntu/

# Update and install Nginx
sudo apt update && sudo apt install nginx -y
sudo systemctl enable nginx

# Set up web folder
sudo mkdir -p /var/www/portfolio
sudo cp -r /home/ubuntu/portfolio-files/* /var/www/portfolio/
sudo chown -R www-data:www-data /var/www/portfolio
sudo chmod -R 755 /var/www/portfolio

# Create Nginx config
sudo nano /etc/nginx/sites-available/portfolio

# Enable site
sudo ln -s /etc/nginx/sites-available/portfolio /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default

# Test and reload
sudo nginx -t
sudo systemctl reload nginx