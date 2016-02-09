#!/bin/bash

yum install -y wget tar

wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz
tar -zxf jdk-7u79-linux-x64.tar.gz

mkdir /usr/lib/jvm
mv jdk1.7.0_79 /usr/lib/jvm

update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.7.0_79/bin/java" 1
update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk1.7.0_79/bin/javac" 1
update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/lib/jvm/jdk1.7.0_79/bin/javaws" 1
chmod a+x /usr/bin/java
chmod a+x /usr/bin/javac
chmod a+x /usr/bin/javaws

java -version
rm -f jdk-7u79-linux-x64.tar.gz

echo export JAVA_HOME=/usr/lib/jvm/jdk1.7.0_79 >> /etc/profile
source /etc/profile


