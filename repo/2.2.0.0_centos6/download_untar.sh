#!/bin/bash

mkdir ${APACHE_DOC_PATH}/hdp


if [ ! -f ${HDP_OUTPUT} ]; then 
  echo "Now download hdp from "${HDP_URL}
  curl ${HDP_URL} -o ${HDP_OUTPUT}
  echo "Untar ${HDP_OUTPUT} to ${APACHE_DOC_PATH}/hdp"
  tar -zxf -C ${APACHE_DOC_PATH}/hdp ${HDP_OUTPUT}
fi


if [ ! -f ${HDP_UTILS_OUTPUT} ]; then 
  echo "Now download hdp-utils from "${HDP_UTILS_URL}
  curl ${HDP_UTILS_URL} -o ${HDP_UTILS_OUTPUT}
  echo "Untar ${HDP_UTILS_OUTPUT} to ${APACHE_DOC_PATH}/hdp"
  tar -zxf ${HDP_UTILS_OUTPUT} -C ${APACHE_DOC_PATH}/hdp
fi


# start apache server
set -e
rm -f /usr/local/apache2/logs/httpd.pid
exec httpd -DFOREGROUND


