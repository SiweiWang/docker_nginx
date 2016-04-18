# Set the base image to Ubuntu
FROM ubuntu:14.04

# Install Nginx
RUN apt-get update && apt-get install -y nginx 

# Append "daemon off;" to the beginning of the configurations
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Setup configuration files for nginx
COPY default /etc/nginx/sites-enabled/
COPY .htpasswd /etc/nginx/
COPY nginx.crt /etc/nginx/ssl/
COPY nginx.key /etc/nginx/ssl/

#Copy over bootstrap file
COPY bootstrap.sh /etc/bootstrap.sh
RUN chmod 755 /etc/bootstrap.sh

#EXPOSE 443

CMD ["/etc/bootstrap.sh"]