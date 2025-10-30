FROM ubuntu:latest

LABEL maintainer="teja@gmail.com"

# Installing required packages
RUN sudo apt update && sudo apt upgrade && sudo install nginx -y

# Copy index.html file into container
COPY index.html /var/www/html/index.html

# Opening the port for webserver to allow HTTP traffic
EXPOSE 80

# Start nginx service
CMD ['nginx','-g','daemon off;']