#!/bin/bash
yum update -y
yum install httpd -y
wget https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
yum localinstall mysql80-community-release-el7-3.noarch.rpm -y
yum install mysql-community-client -y
amazon-linux-extras install php7.4 -y
cd /var/www/html/
rm -fr *
echo "healthy" > healthy.html
wget https://wordpress.org/wordpress-5.5.tar.gz
tar -xzf wordpress-5.5.tar.gz
cp -r wordpress/* /var/www/html/
rm -rf wordpress
rm -rf wordpress-5.5.tar.gz
chmod -R 755 wp-content
chown -R apache:apache wp-content
chmod 755 /var/www/html/
chown apache:apache /var/www/html/
wget https://s3.amazonaws.com/bucketforwordpresslab-donotdelete/htaccess.txt
mv -f htaccess.txt .htaccess
echo '<?php print phpinfo();' | sudo tee --append /var/www/html/phpinfo.php
chkconfig httpd on
service httpd start
