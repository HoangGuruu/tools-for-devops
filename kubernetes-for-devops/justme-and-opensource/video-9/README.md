# [ Kube 9 ] How to use Node Selector in Kubernetes

```
cd play
git clone https://github.com/justmeandopensource/kubernetes.git
vagrant up
# I think we need install and set up vagrant
# It will work with Vitual Box Instead Ec2
cd vagrant-provisioning
mkdir ~/.kube
scp root@master.example.com:/etc/kubernetes/admin.conf ~/.kube/config
kubectl cluster-infor
kubectl get nodes
kubectl get nodes -o wide

kubectl label node kworker2.example.com demoserver=true
kubectl get node kworker2.example.com --show-lables

watch kubectl get all -o wide
```
- Paralell
```
cd ..
cd yamls
ls
vi 1-nginx-deployment.yaml
```
- Add nodeselector
`
    nodeSelector
        demoserver "true"
`
- Change replicas : 1
```
kubectl create -f 1-nginx-deployment.yaml

kubeclt describe pod {name-deploy} | less

kubectl scale deploy nginx-deploy --replicas=2

kubectl delete deploy nginx-deploy
```