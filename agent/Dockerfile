from whylu/docker-ambari:base

#
#need set server-fqdn by using '-e SERVER_FQDN'

RUN yum install -y ambari-agent
RUN yum clean all


ADD ./start_agent.sh /tmp/start_agent.sh
RUN chmod +x /tmp/start_agent.sh
CMD /bin/bash -c "/tmp/start_agent.sh"

