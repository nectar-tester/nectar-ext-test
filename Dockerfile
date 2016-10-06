FROM centos:7.2.1511

# Update and clean
RUN yum -y update; yum clean all

#Install httpd, php and php-mysql
RUN yum install -y httpd php php-mysql

#Install troubleshooting tools
RUN yum install -y nano curl ping iputils nmap telnet


# Optional build tools
# RUN yum install -y gcc-c++ make

# Troubleshooting tools
# RUN yum install -y nano curl ping iputils nmap telnet

# Replace default https conf
COPY config/httpd.conf /etc/httpd/conf/

# Directories
WORKDIR /usr/src
RUN mkdir /usr/src/logs

# Give permissions
RUN chmod -Rf 0777 /run/httpd
RUN chmod -Rf 0777 /etc/httpd/logs
RUN chmod -Rf 0777 /usr/src

COPY config/wordpress.ini /usr/local/etc/php/
COPY config/wordpress.conf /etc/httpd/conf.d/

COPY src/ /usr/src/app/

EXPOSE 8000 8080

ENTRYPOINT ["apachectl", "-DFOREGROUND"]