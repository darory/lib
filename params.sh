#!/bin/bash

# Check if exactly three parameters are provided
#if [ "$#" -ne 1 ]; then
#    echo "Usage: $0 <parameter1>"
#    exit 1
#fi

#domain="$1"

read -p "Please enter the new domain (mywebsite.local): " domain
read -p "(please enter test str): " test

cat <<EOL > /etc/apache2/sites-available/$domain.conf
<VirtualHost *:80>
    ServerAdmin webmaster@$domain
    ServerName $domain
    DocumentRoot /home/alaa/vhosts/$domain

    <Directory /home/alaa/hosts/$domain/>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Require all granted
    </Directory>
    <FilesMatch \.php$>
		SetHandler "proxy:unix:/run/php/php7.2-fpm.sock|fcgi://localhost"
	</FilesMatch>
</VirtualHost>
EOL

mkdir -p /home/alaa/vhosts/$domain

a2ensite $domain
systemctl reload apache2

echo "Domain: $domain created"


# Check if the entry already exists in /etc/hosts
if grep -q "$domain" /etc/hosts; then
    echo "Entry for $domain already exists in /etc/hosts."
    exit 1
fi

# Add entry to /etc/hosts
echo "127.0.0.1	$domain" | sudo tee -a /etc/hosts

echo "Entry for $domain added successfully to /etc/hosts."
