#!/bin/bash

# As step 4, this creates the networks for kubernetes
# sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
sudo kubectl apply -f /vagrant/kube-flannel.yml

# kubectl describe nodes
# kubectl get nodes
