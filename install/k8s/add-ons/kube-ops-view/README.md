```
kubectl create ns monitoring
```
```
kubectl create -f kube-ops-view-auth.yaml  -n monitoring
```

```
kubectl create -f kube-ops-view-deployment.yaml -n monitoring
```
```
kubectl create -f kube-ops-view-redis-deployment.yaml -n monitoring
```
```
kubectl create -f kube-ops-view-service.yaml -n monitoring
```
```
kubectl create -f kube-ops-view-redis-service.yaml -n monitoring
```

```
kubectl get all -n monitoring
```
<pre>
NAME                                       READY   STATUS    RESTARTS   AGE
pod/kube-ops-view-7b47c5594d-g44gm         1/1     Running   0          3m39s
pod/kube-ops-view-redis-7b7b586cf4-qg8jn   1/1     Running   0          3m34s


NAME                          TYPE           CLUSTER-IP    EXTERNAL-IP      PORT(S)        AGE
service/kube-ops-view         LoadBalancer   10.0.34.77    40.127.238.214   80:30748/TCP   2m10s
service/kube-ops-view-redis   ClusterIP      10.0.42.208   <none>           6379/TCP       12s


NAME                                  READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/kube-ops-view         1/1     1            1           3m39s
deployment.apps/kube-ops-view-redis   1/1     1            1           3m34s

NAME                                             DESIRED   CURRENT   READY   AGE
replicaset.apps/kube-ops-view-7b47c5594d         1         1         1       3m39s
replicaset.apps/kube-ops-view-redis-7b7b586cf4   1         1         1       3m34s
</pre>


