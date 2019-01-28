FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install apache2 apache2-doc apache2-utils -y

RUN apt-get install mysql-server -y

RUN apt-get install php libapache2-mod-php php-mysql -y

RUN echo "ServerName localhost" >> ../etc/apache2/apache2.conf
RUN rm ../var/www/html/index.html

RUN service apache2 restart
CMD apachectl -D FOREGROUND

COPY database.sql ../etc/mysql/
RUN service mysql start
RUN mysql -u root -p < ../etc/mysql/database.sql

COPY index.php ../var/www/html