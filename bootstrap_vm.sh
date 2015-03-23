#!/usr/bin/env bash

# make sure the vm is up and running
while [ "`runlevel`" = "unknown" ]; do
	echo "runleel is 'unknown' - waiting for 10s"
	sleep 10
done
echo "runlevel is now valid ('`runlevel`'), kicking off provisioning..."

# become the main user, not root
su vagrant

# equip the base image
sudo apt-get update -y
sudo apt-get install build-essential rsync telnet screen man wget -y
sudo apt-get install strace tcpdump -y
sudo apt-get install libssl-dev zlib1g-dev libcurl3-dev libxslt-dev -y
sudo apt-get install software-properties-common python-software-properties -y
sudo apt-get install git -y

# Install Oracle Java 7
sudo apt-get install curl -y
curl -L --cookie "oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u65-b17/jdk-7u65-linux-x64.tar.gz -o jdk-7-linux-x64.tar.gz
tar xfvz jdk-7-linux-x64.tar.gz
sudo mkdir -p /usr/lib/jvm
sudo mv ./jdk1.7.* /usr/lib/jvm/
sudo update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.7.0_65/bin/java" 1
sudo update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk1.7.0_65/bin/javac" 1
sudo update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/lib/jvm/jdk1.7.0_65/bin/javaws" 1
sudo chmod a+x /usr/bin/java
sudo chmod a+x /usr/bin/javac
sudo chmod a+x /usr/bin/javaws
sudo chown -R root:root /usr/lib/jvm/jdk1.7.0_65
rm jdk-7-linux-x64.tar.gz
rm -f equip_base.sh
rm -f equip_java7_64.sh
java -version

# Install Apache ANT
wget http://apache.mirrors.pair.com/ant/binaries/apache-ant-1.9.4-bin.tar.gz
tar xfvz apache-ant-1.9.4-bin.tar.gz
sudo mv apache-ant-1.9.4 /usr/local
sudo ln -s /usr/local/apache-ant-1.9.4/bin/ant /usr/bin/ant
rm apache-ant-1.9.4-bin.tar.gz

# Install Apache Maven
wget http://supergsego.com/apache/maven/maven-3/3.3.1/binaries/apache-maven-3.3.1-bin.tar.gz
tar xfvz apache-maven-3.3.1-bin.tar.gz
sudo mv apache-maven-3.3.1 /usr/local
sudo ln -s /usr/local/apache-maven-3.3.1/bin/mvn /usr/bin/mvn
rm apache-maven-3.3.1-bin.tar.gz
