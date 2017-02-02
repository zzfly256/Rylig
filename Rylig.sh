#!/bin/sh
#
# Rylig v1.03
# by Rytia
# Blog : www.zzfly.net
#  2014. 9. 6
#  2015. 7. 10
# 2017.2.2
clear
echo ""
echo "    -----------------------------------------"
echo "    |        Welcome to use Rylig v1.03     |"
echo "    |  LLMP Linux + Lighttpd + MySQL + PHP  |"
echo "    -----------------------------------------"
echo ""
#Start Ryligh
read -p "1. Do you want to install lighttpd? [Y/n] " alig
	echo
	case $alig in
	Y|y)
		rylighttpd="y";;
	N|n)
		rylighttpd="n";;
	*)
		echo "Please input Y or n";;
esac

read -p "2. Do you want to install php? [Y/n] " aphp
	echo
	case $aphp in
	Y|y)
		ryphp="y";;
	N|n)
		ryphp="n";;
	*)
		echo "Please input Y or n";;
esac

read -p "3. Do you want to install MySQL Server? [Y/n] " amysql
	echo
	case $amysql in
	Y|y)
		rymysql="y";;
	N|n)
		rymysql="n";;
	*)
		echo "Please input Y or n";;
esac

read -p "4. Do you want to install SQLite? [Y/n] " asqlite
	echo
	case $asqlite in
	Y|y)
		rysqlite="y";;
	N|n)
		rysqlite="n";;
	*)
		echo "Please input Y or n";;
esac

if [ "$rylighttpd" = "y" ]
then
 echo "###Start installing lighttpd ###"
 apt-get remove -y apache*
 apt-get install -y lighttpd
fi

if [ "$ryphp" = "y" ]
then
 echo "###Start installing PHP ###"
 apt-get install -y php5-cgi php5-curl php5-gd php5-idn php-pear php5-imagick php5-imap php5-mcrypt php5-mhash php5-ming php5-ps php5-pspell php5-recode php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl
 lighty-enable-mod fastcgi
 lighty-enable-mod fastcgi-php
 service lighttpd force-reload
fi

if [ "$rymysql" = "y" ]
then
 echo "###Start installing MySQL###"
 apt-get install -y mysql-server php5-mysql
 echo "###Preparing phpMyAdmin###"
 echo '' >> /etc/lighttpd/lighttpd.conf
 echo 'server.tag="LightTPD ( For <a href=http://www.zzfly.net/rylig target=_blank>Rylig</a> )"' >> /etc/lighttpd/lighttpd.conf
 echo '' >> /etc/lighttpd/lighttpd.conf
 echo '$SERVER["socket"] == "0.0.0.0:9001" { ' >> /etc/lighttpd/lighttpd.conf
 echo 'server.document-root = "/var/Rylig/phpMyAdmin" ' >> /etc/lighttpd/lighttpd.conf
 echo '} ' >> /etc/lighttpd/lighttpd.conf
 cd /var
 mkdir Rylig
 cd /var/Rylig
 mkdir phpMyAdmin
 cd /var/Rylig/phpMyAdmin
 wget http://rylig.qiniudn.com/phpmyadmin.zip
 unzip phpmyadmin.zip
 rm -f /var/Rylig/phpMyAdmin/phpmyadmin.zip
fi

if [ "$rysqlite" = "y" ]
then
 echo "###Start installing SQLite ###"
 apt-get install -y sqlite
fi

chown -R www-data:www-data /var/log/lighttpd
chown -R www-data:www-data /var/www

cd /var/www
wget http://rylig.qiniudn.com/ryindex.zip
apt-get install -y unzip
unzip ryindex.zip
rm -f /var/www/ryindex.zip
rm -f /var/www/index.lighttpd.html
 echo '' >> /etc/lighttpd/lighttpd.conf
 echo 'server.tag="LightTPD ( For <a href=http://www.zzfly.net/rylig target=_blank>Rylig</a> )"' >> /etc/lighttpd/lighttpd.conf

service lighttpd restart

clear
echo ""
echo "    -----------------------------------------"
echo "    |        Welcome to use Rylig v1.02     |"
echo "    |        Congratulations to you !!      |"
echo "    | LLMP have installed successfully @~@  |"
echo "    -----------------------------------------"
echo "     You can upload your website to /var/www "
echo "        and access it via http://(YourIP)/    "
echo "      phpMyAdmin :  http://(YourIP):9001 "
echo ""

