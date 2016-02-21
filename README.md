# docker-ambari

## Prerequisites
An Overlay network is needed. <br/>
In every docker-machine(vm or real-machine), use following commands to build a swarm: <br/>
```shell
#start docker deamon with using consul key-value store 
docker daemon -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock --cluster-store=consul://${consul.host.ip}:8500 --cluster-advertise=${network-interface}:2375

#start consul (first)
docker run -d \
    -v /data \
    -p 8300:8300 \
    -p 8301:8301 \
    -p 8301:8301/udp \
    -p 8302:8302 \
    -p 8302:8302/udp \
    -p 8400:8400 \
    -p 8500:8500 \
    -h consul_m01 \
    --name consul_m01 \
    --restart=always \
    progrium/consul -server -advertise ${consul.host.ip} -bootstrap-expect 2
    
#start consul (others)
  docker run -d \
    -v /data \
    -p 8300:8300 \
    -p 8301:8301 \
    -p 8301:8301/udp \
    -p 8302:8302 \
    -p 8302:8302/udp \
    -p 8400:8400 \
    -p 8500:8500 \
    -h consul_m02 \
    --name consul_m02 \
    --restart=always \
    progrium/consul -server -advertise ${this.machine.ip} -join ${consul.host.ip}
    
#start swarm-agent
docker run --name=agent -d \
  --restart=always \
  swarm join --advertise=${this.machine.ip}:2375 consul://${consul.host.ip}:8500

#--
#start a swarm-maanger on any machine in this swarm cluster
docker run -d --name=manager_01 -p 2376:2375 \
  --restart=always \
  swarm manage consul://${consul.host.ip}:8500

#Create an overlay network
docker network create --driver overlay net99

```
<a href="https://docs.docker.com/engine/userguide/networking/get-started-overlay/">See more detail here<a/>


## Pull images
```shell
docker -H tcp://140.92.24.181:2376 pull whylu/docker-ambari:repo_hdp2.3.4_centos6
docker -H tcp://140.92.24.181:2376 pull whylu/docker-ambari:server
docker -H tcp://140.92.24.181:2376 pull whylu/docker-ambari:agent
```

## Create an overlay network
```shell
docker network create --driver overlay net99
```


## Create a local repository for hdp and hdp-utils 
(need netwrok to download hdp)
```shell
docker -H tcp://140.92.24.181:2376 run -d --restart=always --hostname=net99repohdp23centos6.net99 --name=net99repohdp23centos6 --net=net99 -p 80 whylu/docker-ambari:repo_hdp2.3.4_centos6
# see download stat
docker -H tcp://140.92.24.181:2376 logs -f net99repohdp23centos6

```

## Create a ambari server
```shell
docker -H tcp://140.92.24.181:2376 run -d --restart=always --hostname=net99ambari0.net99 --name=net99ambari0 --net=net99 -p 8080 whylu/docker-ambari:server
```

## Create ambari agents as many as you like
```shell
docker -H tcp://140.92.24.181:2376 run -d --restart=always -e SERVER_FQDN=net99ambari0.net99 --hostname=net99ambari1.net99 --name=net99ambari1 --net=net99 whylu/docker-ambari:agent
```

## After net99repohdp23centos6 finish download hdp, go to ambari web to start
At 'Select Stack' step, choose hdp2.3 and change repo url to local
```shell
#HDP
http://net99repohdp22centos6.net99/hdp/HDP/centos6/2.x/updates/2.3.4.0/
#HDP-UTILS
http://net99repohdp22centos6.net99/hdp/HDP-UTILS-1.1.0.20/repos/centos6/
```

At 'Target Hosts'
```shell
net99ambari1.net99
net99ambari2.net99
net99ambari3.net99
net99ambari4.net99
net99ambari5.net99
```

At 'Host Registration Infomation'
select 'Preform manual regestration on hosts and do not use SSH' <br/>
other steps are the same as normal step <a href="http://hortonworks.com/hadoop-tutorial/introducing-apache-ambari-deploying-managing-apache-hadoop/">like this</a>

*1: please ignore the waring about iptables.
