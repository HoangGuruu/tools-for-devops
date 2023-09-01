# Video 2: [Deploy a Reddit Clone with Kubernetes Ingress](https://www.youtube.com/watch?v=9tl0A_rwgu4&list=PL16dpeBne9TC6FWqB6kc7a5CiIcS2vXiX&index=95)
![image](https://github.com/HoangGuruu/DevOps-Learn-about-Kubernetes/assets/111829092/32d147b6-b7ab-40a1-9770-f5fa539f5b95)
[Link blog](https://trainwithshubham.hashnode.dev/deployed-a-reddit-copy-on-kubernetes-with-ingress-enabled#heading-step-1-clone-the-source-code)
### Prerequisites
1. EC2 ( AMI - Ubuntu, Type-t2.medium) 
- Launch 2 instance t2.medium : CI-Server and Deployment-Server
- In CI-Server
```
# Steps:-

# For Docker Installation
sudo apt-get update
sudo apt-get install docker.io -y
sudo usermod -aG docker $USER && newgrp docker

```

### Step 1: Clone the source code
The first step is to clone the source code for the app. You can do this by using this command git clone https://github.com/LondheShubham153/reddit-clone-k8s-ingress.git

### Step 2: Containerize the Application using Docker
Write a Dockerfile with the following code:
```

FROM node:19-alpine3.15

WORKDIR /reddit-clone

COPY . /reddit-clone

RUN npm install 

EXPOSE 3000

CMD ["npm","run","dev"]

```
### Step 3 Building Docker-Image // First , have docker hub
Now it's time to build Docker Image from this Dockerfile. 
```
docker build . -t <DockerHub_Username>/<Imagename>
```


### Step 4 Push the Image To DockerHub
- Now push this Docker Image to DockerHub so our Deployment file can pull this image & run the app in Kubernetes pods.
- First login to your DockerHub account using Command i.e docker login and give your username & password.
```
docker login
```
Then use docker push <DockerHub_Username>/<Imagename> for pushing to the DockerHub.
```
# example
docker push trainwithshubham/reddit-clone:latest
```
You can use an existing docker image i.e trainwithshubham/reddit-clone for deployment.

### In Instances Deployment-Server
### Step 5 Write a Kubernetes Manifest File

```
# Steps:-

# For Docker Installation
sudo apt-get update
sudo apt-get install docker.io -y
sudo usermod -aG docker $USER && newgrp docker

# For Minikube & Kubectl
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube 

sudo snap install kubectl --classic
minikube start --driver=docker
```
- Now, You might be wondering what this manifest file in Kubernetes is. Don't worry, I'll tell you in brief.

- When you are going to deploy to Kubernetes or create Kubernetes resources like a pod, replica-set, config map, secret, deployment, etc, you need to write a file called manifest that describes that object and its attributes either in yaml or json. Just like you do in the ansible playbook.

- Of course, you can create those objects by using just the command line, but the recommended way is to write a file so that you can version control it and use it in a repeatable way.

- Write Deployment.yml file
Let's Create a Deployment File For our Application. Use the following code for the Deployment.yml file.
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: reddit-clone-deployment
  labels:
    app: reddit-clone
spec:
  replicas: 2
  selector:
    matchLabels:
      app: reddit-clone
  template:
    metadata:
      labels:
        app: reddit-clone
    spec:
      containers:
      - name: reddit-clone
        image: trainwithshubham/reddit-clone
        ports:
        - containerPort: 3000
```

- Write Service.yml file
```
apiVersion: v1
kind: Service
metadata:
  name: reddit-clone-service
  labels:
    app: reddit-clone
spec:
  type: NodePort
  ports:
  - port: 3000
    targetPort: 3000
    nodePort: 31000
  selector:
    app: reddit-clone

```
### Step 6 Deploy the app to Kubernetes & Create a Service For It
Now, we have a deployment file for our app and we have a running Kubernetes cluster, we can deploy the app to Kubernetes. To deploy the app you need to run following the command: 
```
kubectl apply -f Deployment.yml 
kubectl apply -f Service.yml
```
# If You want to check your deployment & Service use the command 
kubectl get deployment & kubectl get services
```

- It's can go to step 8 to first check

### Step 7 Let's Configure Ingress
If you want to check the current setting for addons in minikube use minikube addons list command.
- Minikube doesn't enable ingress by default; we have to enable it first using minikube addons enable ingress command.
```
minikube addons enable ingress
```
Ingress:
Pods and services in Kubernetes have their own IP; however, it is normally not the interface you'd provide to the external internet. Though there is a service with node IP configured, the port in the node IP can't be duplicated among the services. It is cumbersome to decide which port to manage with which service. Furthermore, the node comes and goes, it wouldn't be clever to provide a static node IP to an external service. Ingress defines a set of rules that allows the inbound connection to access Kubernetes cluster services. It brings the traffic into the cluster at L7 and allocates and forwards a port on each VM to the service port. This is shown in the following figure. We define a set of rules and post them as source type ingress to the API server. When the traffic comes in, the ingress controller will then fulfill and route the ingress by the ingress rules. As shown in the following figure, ingress is used to route external traffic to the Kubernetes endpoints by different URLs:

Let's write ingress.yml and put the following code in it:
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ingress-reddit-app
spec:
  rules:
  - host: "domain.com"
    http:
      paths:
      - pathType: Prefix
        path: "/test"
        backend:
          service:
            name: reddit-clone-service
            port:
              number: 3000
  - host: "*.domain.com"
    http:
      paths:
      - pathType: Prefix
        path: "/test"
        backend:
          service:
            name: reddit-clone-service
            port:
              number: 3000

```


Now you can able to create ingress for your service. 
``` 
kubectl apply -f ingress.yml 
# use this command to apply ingress settings.
```
Verify that the ingress resource is running correctly by using 
```
kubectl get ingress ingress-reddit-app command.
```
- Test
```
curl -L domain.com/test
```
### Step 8 Expose the app
- Add Security Group for 3000
- First We need to expose our deployment so use 
```
kubectl expose deployment reddit-clone-deployment --type=NodePort command.
```
- Check in Ip:3000


- You can test your deployment using 
```
curl -L http://192.168.49.2:31000. 192.168.49.2 is a minikube ip & Port 31000 is defined in Service.yml
```
- Then We have to expose our app service kubectl port-forward svc/reddit-clone-service 3000:3000 --address 0.0.0.0 &

Test Ingress
Now It's time to test your ingress so use the curl -L domain/test command in the terminal.
