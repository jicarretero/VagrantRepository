IPADDR=$(ip a show enp0s8 | awk '/ inet / {print gensub(/([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)\/([0-9]+)/,"\\1","g",$2)}') 

sudo kubeadm join 192.168.50.10:6443 --token jzouhz.x5axy23wqfhbwpgz \
    --discovery-token-ca-cert-hash sha256:6f9b6e464c56a4f59e6de7640f5a12c07a5617e1d7fc5d67d1d14ee601924b0c  --apiserver-advertise-address $IPADDR


sube kubeadm join xxxx --token u6q0jw.789oqdcjhsd35xp9 \
    --discovery-token-ca-cert-hash
