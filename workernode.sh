cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF


sudo sysctl --system

sudo apt-get update && sudo apt-get install -y containerd.io 
sudo mkdir -p /etc/containerd 
sudo containerd config default | sudo tee /etc/containerd/config.toml 
sudo systemctl restart containerd 
sudo systemctl status containerd 


sudo swapoff -a 
sudo apt-get update && sudo apt-get install -y apt-transport-https curl 


curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - 


https://apt.kubernetes.io/ kubernetes-xenial main 
EOF 

sudo apt-get update
sudo apt-get install -y kubelet=1.24.0-00 kubeadm=1.24.0-00 kubectl=1.24.0-00


sudo apt-mark hold kubelet kubeadm kubectl 
Initialize the Cluster



# In both worker nodes, paste the kubeadm join command to join the cluster. Use sudo to run it as root:
sudo kubeadm join ...

