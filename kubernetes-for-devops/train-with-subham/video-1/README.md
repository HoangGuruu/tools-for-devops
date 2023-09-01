# Video 1: [Kubernetes Explained for DevOps Enginners](https://www.youtube.com/watch?v=FqfoDUhzyDo&list=PL16dpeBne9TC6FWqB6kc7a5CiIcS2vXiX&index=96)

- Explained about Kubernetes
- Launch a EC2 Ubuntu instance with t2.medium

- Install minikube
	+ [Link](https://minikube.sigs.k8s.io/docs/start/)
```
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
# - Install docker 

```
- Install docker engine
	+ [Link](https://docs.docker.com/engine/install/ubuntu/)
```
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# verify
sudo docker run hello-world
```
- Then 
```
sudo usermod -aG docker $USER && newgrp docker

minikube start --driver=docker
```
- Install kubectl
```
kubectl get po -A
sudo snap install kubectl
sudo snap install kubectl --classic
kubectl get po -A
minikube status
kubectl get node
```