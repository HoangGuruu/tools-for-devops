# Video 3 : Add this Project in your DevOps Resume // [Kubernetes Deployment](https://www.youtube.com/watch?v=ONrbWFJXLLk&list=PL16dpeBne9TC6FWqB6kc7a5CiIcS2vXiX&index=104&t=1s) [Freshers]
-----------------
- Built Kubernetes Cluster on AWS from scratch with Minikube
- Setup and Managed Docker Containers for Django and React Applications into Kubernetes Pods
- Managed Deployment, Replication, Autohealing , Auto Scaling for Kubernetes Cluster 
- Managed network and Services with Host IP allocation through Proxy on AWS EC2 and Route53
-> Reduce Downtime by 75% on Production Environments
-----------------

- Have a EC2 instance t2.medium Ubuntu 
- Git clone URL Repository
```
git clone {URL}
```
- Then
```
docker build -t trainwithshubham/django-todo:lastest

docker run -d -p 8000:8000 trainwithshubham/django-todo:lastest

```
- Then
```
curl -L http://ip:8000
```

```
mkdir k8s
cd k8s
ls
docker images
docker push trainwithshubham/django-todo
vim pod.yaml
```
- Then check in google : pod kubenetes | And copy simple
```
apiVersion: v1
kind: Pod
metadata:
  name: todo-pod
spec:
  containers:
  - name: todo-app
    image: trainwithshubham/django-todo:lastest
    ports:
    - containerPort: 8000

```
- Then 
```
docker ps
# if exits
docker kill {Container ID}
kubectl apply -f pod.yaml
# Check 
kubectl get pods
```

- Then vim deployment.yaml
- Check in google : deployment kubernetes
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: todo-deployment
  labels:
    app: todo-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: todo-app
  template:
    metadata:
      labels:
        app: todo-app
    spec:
      containers:
      - name: todo-app
        image: trainwithshubham/django-todo:lastest
        ports:
        - containerPort: 8000

```
- Then
```
kubectl apply -f deployment.yaml
kubectl get deployments
kubectl get pods
```
- Check 
```
kubectl delete pods todo-pod
kubectl get pods
kubectl delete pods todo-deployment-....
kubectl get pods
```

- Step 4 : 
```
kubectl get pods -o wide
curl -L http://Ip:8000
# it fail
```
- Then vim service.yaml | Check in google : service kubernetes
- Find NodePort
```
apiVersion: v1
kind: Service
metadata:
  name: todo-service
spec:
  type: NodePort
  selector:
    app: todo-app
  ports:
      # By default and for convenience, the `targetPort` is set to the same value as the `port` field.
    - port: 80
      targetPort: 8000
      # Optional field
      # By default and for convenience, the Kubernetes control plane will allocate a port from a range (default: 30000-32767)
      nodePort: 30007
```
```
kubectl apply -f service.yaml
kubectl get svc
minikube service todo-service --url
# use this URL 
curl -L URL:30007
```

- Then 
```
sudo vim /etc/hosts
```
- Add this {IP todo-app.com} in there
- Then
```
curl -L todo-app.com:30007
```

- Then
```
kubectl get pods
```