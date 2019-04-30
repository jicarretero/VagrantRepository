#!/bin/bash

## 
## Install Docker
##

cd ~

cat << EOT > /etc/rc.local
echo nameserver 8.8.8.8 > /etc/resolv.conf

cd /root

OC_CLUSTER_PUBLIC_HOSTNAME=oshift.local oc-cluster-wrapper/oc-cluster up os1
exit 0
EOT

echo nameserver 8.8.8.8 > /etc/resolv.conf

apt-mark hold grub-pc

export DEBIAN_FRONTEND=noninteractive

# sudo apt-get -y update && sudo apt-get -y dist-upgrade
apt-get dist-upgrade  -o Dpkg::Options::="--force-confdef" -o Dpkg::Options="--force-confold" -y


sudo apt-get install -y \
   apt-transport-https \
   ca-certificates \
   software-properties-common \
   mysql-client \
   curl \
   lsof \
   mosquitto-clients \
   jq \
   vim

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"
sudo apt-get -y update
sudo apt-get install -y docker-ce

## 
## Install Docker-compose
##
curl -L https://github.com/docker/compose/releases/download/1.23.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose


IP=$(ip a show eth0 | awk '/inet / {print gensub(/([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)\/([0-9]+)/,"\\1","g",$2)}')
echo $IP    oshift.local >> /etc/hosts

##
## Install Openshift
## 
sed -i 's|^ExecStart=/usr/bin/dockerd .*|ExecStart=/usr/bin/dockerd --insecure-registry 172.30.0.0/16 -H unix://|g' /lib/systemd/system/docker.service

systemctl daemon-reload

service docker restart
wget https://github.com/openshift/origin/releases/download/v3.6.0/openshift-origin-client-tools-v3.6.0-c4dd4cf-linux-64bit.tar.gz
tar xfz openshift-origin-client-tools-v3.6.0-c4dd4cf-linux-64bit.tar.gz
cp -a openshift-origin-client-tools-v3.6.0-c4dd4cf-linux-64bit/oc /usr/local/sbin/
rm -fr openshift-origin-client-tools-v3.6.0-c4dd4cf-linux-64bit*
git clone https://github.com/openshift-evangelists/oc-cluster-wrapper
echo 'PATH=$HOME/oc-cluster-wrapper:$PATH' >> $HOME/.bash_profile
echo 'export PATH' >> $HOME/.bash_profile

apt-get install -y golang
mkdir go
export GOPATH=$PWD/go
go get github.com/kubernetes/kompose

cp ./go/bin/kompose /usr/local/bin

OC_CLUSTER_PUBLIC_HOSTNAME=oshift.local oc-cluster-wrapper/oc-cluster up os1
