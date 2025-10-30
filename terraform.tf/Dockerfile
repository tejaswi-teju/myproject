FROM ubuntu:latest

LABEL maintainer="teja@gmail.com"

# Installing required packages
RUN apt update && apt upgrade -y && apt install nginx -y

# Copy index.html file into container
COPY terraform.tf/index.html /var/www/html/index.html

# Opening the port for webserver to allow HTTP traffic
EXPOSE 80

# Start nginx service
CMD ['nginx','-g','daemon off;']