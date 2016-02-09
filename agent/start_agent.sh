#!/bin/bash

if [ ! -f /opt/server_fqdn ]; then
  sed -i -- "s/hostname=localhost/hostname=${SERVER_FQDN}/g" /etc/ambari-agent/conf/ambari-agent.ini
  echo ${SERVER_FQDN} >> /opt/server_fqdn
  echo "set ambari server fqdn="${SERVER_FQDN}
fi

ambari-agent start && tail -f /var/log/ambari-agent/ambari-agent.log

