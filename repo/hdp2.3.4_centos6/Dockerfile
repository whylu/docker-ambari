from httpd:2.4


ENV APACHE_DOC_PATH=/usr/local/apache2/htdocs
ENV OS_VERSION=centos6
ENV AMBARI_VERSION=2.2.0.0
ENV HDP_VERSION=2.3.4.0
ENV HDP_UTILS_VERSION=1.1.0.20


RUN apt-get -qq update && apt-get -qq -y install curl tar

#download ambari
#ENV AMBARI_URL=http://public-repo-1.hortonworks.com/ambari/${OS_VERSION}/2.x/updates/${AMBARI_VERSION}/ambari-${AMBARI_VERSION}-${OS_VERSION}.tar.gz
#ENV AMBARI_OUTPUT=${APACHE_DOC_PATH}/ambari-${AMBARI_VERSION}-${OS_VERSION}.tar.gz
#RUN curl ${AMBARI_URL} -o ${AMBARI_OUTPUT} && tar -zxf ${AMBARI_OUTPUT}

#hdp
ENV HDP_URL=http://public-repo-1.hortonworks.com/HDP/${OS_VERSION}/2.x/updates/${HDP_VERSION}/HDP-${HDP_VERSION}-${OS_VERSION}-rpm.tar.gz
ENV HDP_OUTPUT=${APACHE_DOC_PATH}/hdp/HDP-${HDP_VERSION}-${OS_VERSION}-rpm.tar.gz

#hdp-utils
ENV HDP_UTILS_URL=http://public-repo-1.hortonworks.com/HDP-UTILS-${HDP_UTILS_VERSION}/repos/${OS_VERSION}/HDP-UTILS-${HDP_UTILS_VERSION}-${OS_VERSION}.tar.gz
ENV HDP_UTILS_OUTPUT=${APACHE_DOC_PATH}/hdp/HDP-UTILS-${HDP_UTILS_VERSION}-${OS_VERSION}.tar.gz


#remove index page
RUN rm -f /usr/local/apache2/htdocs/index.html


ADD ./download_untar.sh /tmp/download_untar.sh
RUN chmod +x /tmp/download_untar.sh
CMD /tmp/download_untar.sh


