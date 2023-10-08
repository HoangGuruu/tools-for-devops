![7](https://github.com/HoangGuruu/tools-for-devops/assets/111829092/8dd812ac-7749-455b-98c3-68395bbbaad0)

# 1. kubectl Cheat Sheet
Link : https://kubernetes.io/vi/docs/reference/kubectl/cheatsheet/ 
## Tạo một đối tượng
```
kubectl apply -f ./my-manifest.yaml            # tạo tài nguyên
kubectl apply -f ./my1.yaml -f ./my2.yaml      # tạo từ nhiều tệp
kubectl apply -f ./dir                         # tạo tài nguyên từ tất cả các tệp manifest trong thư mục dir
kubectl apply -f https://git.io/vPieo          # tạo tài nguyên từ url
kubectl create deployment nginx --image=nginx  # tạo một deployment nginx
kubectl explain pods,svc                       # lấy thông tin pod và service manifest
```

## Xem, tìm các tài nguyên
```
# Lệnh get với một số đầu ra cơ bản
kubectl get services                          # Liệt kê tất cả các services trong namespace
kubectl get pods --all-namespaces             # Liệt kê tất cả các pods trong tất cả các namespaces
kubectl get pods -o wide                      # Liệt kê tất cả các pods namespace, với nhiều thông tin hơn
kubectl get deployment my-dep                 # Liệt kê một deployment cụ thể
kubectl get pods                              # Liệt kê tất cả các pods trong namespace
kubectl get pod my-pod -o yaml                # Lấy thông tin của một pod ở dạng YAML
kubectl get pod my-pod -o yaml --export       # Lấy thông tin của một pod ở dạng YAML mà không có thông tin cụ thể về cụm

# Lệnh describe
kubectl describe nodes my-node
kubectl describe pods my-pod

```
## Chỉnh sửa các tài nguyên
```
kubectl edit svc/docker-registry                      # Chỉnh sửa services có tên docker-registry
KUBE_EDITOR="nano" kubectl edit svc/docker-registry   # Sử dụng một trình soạn thảo thay thế
```
## Scaling tài nguyên
```
kubectl scale --replicas=3 rs/foo                                 # Scale một replicaset có tên 'foo' thành 3
kubectl scale --replicas=3 -f foo.yaml                            # Scale một tài nguyên được xác định trong "foo.yaml" thành 3
kubectl scale --current-replicas=2 --replicas=3 deployment/mysql  # Nếu kích thước hiện tại của deployment mysql là 2, scale mysql thành 3
kubectl scale --replicas=5 rc/foo rc/bar rc/baz                   # Scale nhiều replication controllers
```
## Xóa tài nguyên
```
kubectl delete -f ./pod.json                                              # Xóa một pod sử dụng loại và tên được xác định trong pod.json
kubectl delete pod,service baz foo                                        # Xóa pods và services có tên "baz" và "foo"
kubectl delete pods,services -l name=myLabel                              # Xóa pods và services có nhãn name=myLabel
kubectl -n my-ns delete pod,svc --all                                     # Xóa tất cả pods và services trong namespace my-ns,
# Xóa tất cả pods matching với pattern1 hoặc pattern2
kubectl get pods  -n mynamespace --no-headers=true | awk '/pattern1|pattern2/{print $1}' | xargs  kubectl delete -n mynamespace pod
```
## Tương tác với các pods đang chạy
```
kubectl logs my-pod                                 # kết xuất logs của pod (stdout)
kubectl logs -l name=myLabel                        # kết xuất logs của pod có nhãn name=myLabel (stdout)
kubectl logs my-pod --previous                      # kết xuất logs của pod (stdout) cho khởi tạo trước của một container
kubectl logs my-pod -c my-container                 # kết xuất logs của container của pod (stdout, trường hợp có nhiều container)
kubectl logs -l name=myLabel -c my-container        # kết xuất logs của container có tên my-container và có nhãn name=myLabel (stdout)
kubectl logs my-pod -c my-container --previous      # kết xuất logs của container my-container của pod my-pod (stdout, trường hợp có nhiều container) cho khởi tạo trước của một container
kubectl logs -f my-pod                              # lấy logs của pod my-pod (stdout)
kubectl logs -f my-pod -c my-container              # lấy logs của container my-container trong pod my-pod (stdout, trường hợp nhiều container)
kubectl logs -f -l name=myLabel --all-containers    # lấy logs của tất cả các container của pod có nhãn name=myLabel (stdout)
kubectl run -i --tty busybox --image=busybox -- sh  # Chạy pod trong một shell tương tác
kubectl run nginx --image=nginx --restart=Never -n 
mynamespace                                         # Chạy pod nginx trong một namespace cụ thể
kubectl run nginx --image=nginx --restart=Never     # Chạy pod nginx và ghi spec của nó vào file có tên pod.yaml
--dry-run -o yaml > pod.yaml

kubectl attach my-pod -i                            # Đính kèm với container đang chạy
kubectl port-forward my-pod 5000:6000               # Lắng nghe trên cổng 5000 của máy local và chuyển tiếp sang cổng 6000 trên pod my-pod
kubectl exec my-pod -- ls /                         # Chạy lệnh trong một pod (trường hợp 1 container)
kubectl exec my-pod -c my-container -- ls /         # Chạy lệnh trong pod (trường hợp nhiều container)
kubectl top pod POD_NAME --containers               # Hiển thị số liệu của pod và container chạy trong nó
```
## Tương tác với các nodes và cụm
```                              
kubectl cluster-info                                                  # Hiển thị địa chỉ master và các services
```