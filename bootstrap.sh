#!/usr/bin/env bash
echo "Updating packages list"
sudo apt-get update

echo "Installing NFS stuff"
sudo apt-get install -y nfs-common portmap

echo "Installing MySQL"
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

echo "Installing curl, vim, git etc. "
sudo apt-get install -y curl python-software-properties vim git-core

echo "Installing PHP"
# sudo add-apt-repository -y ppa:ondrej/php5-oldstable  # for latest PHP 5.4
sudo add-apt-repository -y ppa:ondrej/php5 # for latest PHP 5.5

echo "Update package list again"
sudo apt-get update

echo "Installing PHP and related"
sudo apt-get install -y php5 apache2 libapache2-mod-php5 php5-curl php5-gd php5-mcrypt mysql-server-5.5 php5-mysql
sudo a2enmod rewrite

echo "Configuring Apache"
sudo rm -rf /var/www

# sudo ln -fs /vagrant/public /var/www # for Laravel
sudo ln -fs /vagrant/web /var/www # for Symfony

sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini
sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/sites-enabled/000-default

sudo service apache2 restart

echo "Installing composer"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

echo "Installing node, grunt, bower"
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install -y python-software-properties python g++ make nodejs
sudo npm -g install grunt-cli bower
