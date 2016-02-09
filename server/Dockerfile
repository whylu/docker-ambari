from whylu/docker-ambari:base

ENV JAVA_HOME=/usr/lib/jvm/jdk1.7.0_79

RUN yum install -y ambari-server
RUN yum clean all

RUN ambari-server setup --silent --java-home $JAVA_HOME

EXPOSE 8080
CMD ambari-server start && tail -f /var/log/ambari-server/ambari-server.log

