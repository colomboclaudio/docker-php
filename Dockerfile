FROM ubuntu:17.04

#Set Proxy
#ENV http_proxy http://xxx.xxx.xxx.xxx:xxxx
#ENV https_proxy https://xxx.xxx.xxx.xxx:xxxx

#Copia chiave ppa e aggiunta
#ppa.key ricavata da: http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x4F4EA0AAE5267A6C
COPY ppa.key /root/ppa.key
RUN apt-key add /root/ppa.key

#add repo list
COPY repos.list /etc/apt/sources.list.d/php56.list

#install package
RUN apt-get update && apt-get install -y nano software-properties-common
RUN apt-get install -y apache2 php php-mysql php-mysql php-xml php-zip php-curl
RUN apt-get install -y python python-pip
RUN pip install openpyxl

#start service apache2
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_RUN_DIR /var/run 
EXPOSE 80
CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]

#RUN php -v > /root/php_version.txt