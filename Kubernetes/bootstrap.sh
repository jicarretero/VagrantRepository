#!/bin/bash

# Tuturial from: https://vitux.com/install-and-deploy-kubernetes-on-ubuntu/

apt-get -y update
apt-get dist-upgrade  -o Dpkg::Options::="--force-confdef" -o Dpkg::Options="--force-confold" -y
apt-get -y clean
apt-get -y autoremove

apt -y install software-properties-common docker.io curl
systemctl enable docker

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg |  apt-key  add 

apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
apt-get -y update
apt -y install kubeadm

sudo sysctl net.bridge.bridge-nf-call-iptables=1
echo "net.bridge.bridge-nf-call-iptables=1" >> /etc/sysctl.conf

cat << EOT >> /etc/hosts

192.168.50.10	master
192.168.50.11   slave1
192.168.50.12   slave2
EOT
