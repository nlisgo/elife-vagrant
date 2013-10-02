#!/bin/sh
mkdir -p /vagrant/public/elife.vbox.local/www
cp -r -f /vagrant/public/files/ /vagrant/public/elife.vbox.local/www/files/
cp /vagrant/public/settings.php /vagrant/public/elife.vbox.local/www/
cp -r -f ~/localgit/* /vagrant/public/elife.vbox.local/www/
cd /vagrant/public/elife.vbox.local/www/default-webroot/sites/default 
ln -s ../../../files files
ln -s ../../../files files
ln -s ../../../drupal-site-jnl-elife/modules modules
sudo ln -s ../../../settings.php settings.php
sudo ln -s ../../../drupal-site-jnl-elife/themes themes
sudo /etc/init.d/apache2 restart