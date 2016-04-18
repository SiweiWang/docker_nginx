#!/bin/bash

# boostrap the puppet_server in docker container
# This will :
#  1. Update the puppet master host in puppet.conf file under /etc/puppet 
#  2. Starts puppetdb in foreground

set -xe

check_input(){
  if [ -z "$SERVICE_NAME" ]; then
    echo "Service name is not set"
    exit 1;
  elif [ -z "$SERVICE_PORT" ]; then
    echo "Pupept db max heap size is not set"
    exit 1;
  fi
}

start_nginx(){
  service nginx start
}

update_ngix_config(){
  sed -i "s/SERVICE_NAME/$SERVICE_NAME/g" /etc/nginx/sites-enabled/default
  sed -i "s/SERVICE_PORT/$SERVICE_PORT/g" /etc/nginx/sites-enabled/default

  if [ -z "$SECURE_PORT" ]; then
    # Use default https port
    sed -i "s/SECURE_PORT/443/g" /etc/nginx/sites-enabled/default
  else
    sed -i "s/SECURE_PORT/$SECURE_PORT/g" /etc/nginx/sites-enabled/default
  fi
}

main(){
  check_input
  update_ngix_config
  cat /etc/nginx/sites-enabled/default
  start_nginx
}

main