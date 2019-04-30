#!/bin/bash

# sudo kubeadm init --pod-network-cidr=10.244.0.0/16

sudo kubeadm init --apiserver-advertise-address=192.168.50.10 --pod-network-cidr=10.244.0.0/16

mkdir -p ~vagrant/.kube
cp -i /etc/kubernetes/admin.conf ~vagrant/.kube/config
chown -R vagrant:vagrant ~vagrant/.kube
