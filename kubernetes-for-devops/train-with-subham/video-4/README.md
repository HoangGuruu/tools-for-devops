# Video 4 : [Kubernetes Project](https://www.youtube.com/watch?v=LPaWASGjwbs&list=PL16dpeBne9TC6FWqB6kc7a5CiIcS2vXiX&index=105) - Microservices on Kubeadm // Flask & MongoDb // DevOps Troubleshooting

### 6.1 Setting up Kubernetes Cluster Suing Kubeadm
- Create 2 EC2 kubernetes-master , and change to kubernetes-worker
	+ Ubuntu
	+ t2.medium
	+ allow 22 , 80 , 443
	 
```
---------------------------------------- Kubeadm Installation ------------------------------------------ 

-------------------------------------- Both Master & Worker Node ---------------------------------------
sudo su
apt update -y
apt install docker.io -y

systemctl start docker
systemctl enable docker

curl -fsSL "https://packages.cloud.google.com/apt/doc/apt-key.gpg" | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/kubernetes-archive-keyring.gpg
echo 'deb https://packages.cloud.google.com/apt kubernetes-xenial main' > /etc/apt/sources.list.d/kubernetes.list

apt update -y
apt install kubeadm=1.20.0-00 kubectl=1.20.0-00 kubelet=1.20.0-00 -y

## To connect with cluster execute below commands on master node and worker node respectively

--------------------------------------------- Master Node -------------------------------------------------- 
sudo su
kubeadm init

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
  # or alternative
  export KUBECONFIG=/etc/kubernetes/admin.conf
kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml

kubeadm token create --print-join-command
  

------------------------------------------- Worker Node ------------------------------------------------ 
sudo su
kubeadm reset pre-flight checks
-----> Paste the Join command on worker node and append `--v=5` at end

# To verify cluster connection  
---------------------------------------on Master Node-----------------------------------------

kubectl get nodes 


# worker
# kubeadm join 172.31.84.66:6443 --token n4tfb4.grmew1s1unug0get     --discovery-token-ca-cert-hash sha256:c3fda2eaf5960bed4320d8175dc6a73b1556795b1b7f5aadc07642ed85c51069 --v=5
	# Then add Security Group : 6443 {..} 
# kubeadm reset pre-flight checks
# kubeadm token create --print-join-command
# kubectl label node ip-172-31-20-246 node-role.kubernetes.io/worker=worker
# kubectl label nodes ip-172-31-92-99 kubernetes.io/role=worker
# kubectl config set-context $(kubectl config current-context) --namespace=dev
```

### 6.2 Deployment of Microservices application
- git clone URL
- Check
```
cd flask-api/
cd k8s
cat taskmaster.yml
```
- Then
```
kubectl apply -f taskmaster.yml
kubectl get pods
```
- Then in Worker - Check
```
docker ps
```
- Then in Master
```
kubectl scale --replicas=3 deployment/taskmaster
kubectl get pods
```
- Check in taskmaster-svc.yml
- Then
```
kubectl apply -f taskmaster-svc.yml
kubectl get svc taskmaster...

```

### 6.3 Exposing the App and test on Postman
- Add Security Group - 30007 in Kubernetes-master
- Check in Postman : http://ipworker:30007
### 6.4 Setting up MongoDB in Kubernetes Cluster

```
vim mongo-pv.yml
kubectl apply -f mongo-pv.yml

vim mongo-pvc.yml
kubectl apply -f mongo-pvc.yml

kubectl get pv mongo-pv
kubectl get pvc mongo-pvc 

vim mongo.yml
kubectl apply -f mongo.yml
kubectl get pods
```
### 6.5 Testing MongoDb in K8s
- In Worker 
```
docker ps
docker exec -it {CONTAINER ID}
```
### 6.6 Kubernetes Troubleshooting

- > So i think need learn about PostMan : RESTful API