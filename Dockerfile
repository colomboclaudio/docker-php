FROM ubuntu:17.04

#Set Proxy
#ENV http_proxy http://XXX:XXXX
#ENV https_proxy http://XXX:XXXX

#Copia chiave ppa e aggiunta
#ppa.key ricavata da: http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x4F4EA0AAE5267A6C
COPY ppa.key /root/ppa.key
RUN apt-key add /root/ppa.key

#add repo list
COPY repos.list /etc/apt/sources.list.d/php56.list

#install package
RUN apt-get update && apt-get install -y nano software-properties-common
RUN apt-get install -y apache2 php5.6 php5.6-mysql php5.6-mysql php5.6-xml php5.6-zip php5.6-curl

#start service apache2
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_RUN_DIR /var/run 
EXPOSE 80
CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]

#RUN php -v > /root/php_version.txt
