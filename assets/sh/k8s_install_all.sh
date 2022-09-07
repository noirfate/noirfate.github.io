#!/bin/bash
set -e
if [ $# -lt 1 ];then
    echo "please specify k8s version"
    exit 1
fi
version=$1
apt update
apt install -y curl apt-transport-https wget
curl -fsSL https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add -
add-apt-repository "deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main"
wget https://github.com/Mirantis/cri-dockerd/releases/download/v0.2.5/cri-dockerd_0.2.5.3-0.ubuntu-bionic_amd64.deb
dpkg -i cri-dockerd_0.2.5.3-0.ubuntu-bionic_amd64.deb
sed -i 's/ExecStart.*/ExecStart=\/usr\/bin\/cri-dockerd --pod-infra-container-image=registry.aliyuncs.com\/google_containers\/pause:3.7/' /lib/systemd/system/cri-docker.service
systemctl daemon-reload
systemctl restart cri-docker
kubelet_version=`apt-cache madison kubelet | grep $version | awk -F '|' '{gsub(/ /, "", $2);print $2}'`
cni_version=`apt show kubelet=$kubelet_version | grep kubernetes-cni | awk -F ',' '{gsub(/ /, "", $2);split($2,a,"(");if(a[1] != "kubernetes-cni") exit 255;split(a[2],b,"=");split(b[2],c,")");print c[1]}'`
cni_version=`apt-cache madison kubernetes-cni | grep $cni_version | awk -F '|' '{gsub(/ /, "", $2);print $2}'`
apt install -y --allow-downgrades kubernetes-cni=$cni_version
apt install -y --allow-downgrades kubelet=$kubelet_version kubeadm=$kubelet_version kubectl=$kubelet_version
master_ip=`ifconfig eth0 | awk 'NR>1 {print $2}' | head -1`
swapoff -a
modprobe br_netfilter
cat >> /etc/sysctl.d/k8s.conf << EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
vm.swappiness=0
EOF
sysctl -p /etc/sysctl.d/k8s.conf
echo -e "$master_ip\tmaster\n" >> /etc/hosts
kubeadm config print init-defaults > kubeadm.yaml
sed -i 's/var\/run\/.*/var\/run\/cri-dockerd.sock/' kubeadm.yaml
sed -i 's/k8s.gcr.io/registry.aliyuncs.com\/google_containers/' kubeadm.yaml
sed -i "s/kubernetesVersion:.*/kubernetesVersion: $version/" kubeadm.yaml
sed -i "s/advertiseAddress:.*/advertiseAddress: $master_ip/" kubeadm.yaml
sed -i '/serviceSubnet/a\  podSubnet: 10.224.0.0\/16' kubeadm.yaml
sed -i "s/name:.*/name: master/" kubeadm.yaml
sed -i '/taints/a\  kubeletExtraArgs:\n    enforce-node-allocatable: ""' kubeadm.yaml
cat >> kubeadm.yaml << EOF
---
apiVersion: kubelet.config.k8s.io/v1beta1
kind: KubeletConfiguration
enforceNodeAllocatable: []
cgroupsPerQOS: false
EOF
kubeadm init --ignore-preflight-errors=NumCPU,cri,SystemVerification,Service-Docker --config=kubeadm.yaml
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
curl -O https://docs.projectcalico.org/manifests/calico.yaml
kubectl apply -f calico.yaml
kubectl taint nodes --all node-role.kubernetes.io/master-
kubectl taint nodes --all node-role.kubernetes.io/control-plane- 2>/dev/null || true
#kubeadm reset --cri-socket unix:///var/run/cri-docker.sock
#kubeadm config images list --config kubeadm.yaml
#kubeadm config images pull --config kubeadm.yaml
