```
kubectl create -f kube-ops-view-namespace.yaml
```
```
kubectl create -f kube-ops-view-auth.yaml  -n monitor
```
```
kubectl create -f kube-ops-view-rbac.yaml -n monitor
```
```
kubectl create -f kube-ops-view-deployment.yaml -n monitor
```
```
kubectl create -f kube-ops-view-redis-deployment.yaml -n monitor
```
```
kubectl create -f kube-ops-view-service.yaml -n monitor
```
```
kubectl create -f kube-ops-view-redis-service.yaml -n monitor
```

```
kubectl get all -n monitor
```
<pre>
NAME                                       READY   STATUS    RESTARTS   AGE
pod/kube-ops-view-7b47c5594d-cm4s6         1/1     Running   0          70s
pod/kube-ops-view-redis-7b7b586cf4-fxm7b   1/1     Running   0          63s

NAME                    TYPE           CLUSTER-IP    EXTERNAL-IP   PORT(S)        AGE
service/kube-ops-view   LoadBalancer   10.0.78.123   40.127.238.12 80:30846/TCP   3s

NAME                                  READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/kube-ops-view         1/1     1            1           70s
deployment.apps/kube-ops-view-redis   1/1     1            1           63s

NAME                                             DESIRED   CURRENT   READY   AGE
replicaset.apps/kube-ops-view-7b47c5594d         1         1         1       70s
</pre>


