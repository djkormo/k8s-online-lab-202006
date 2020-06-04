```
kubectl create ns monitoring
```
```
kubectl create -f kube-ops-view-auth.yaml  -n monitoring
```
serviceaccount/kube-ops-view created
clusterrole.rbac.authorization.k8s.io/kube-ops-view created
clusterrolebinding.rbac.authorization.k8s.io/kube-ops-view created

```
kubectl create -f kube-ops-view-deployment.yaml -n monitoring
```
deployment.apps/kube-ops-view created
```
kubectl create -f kube-ops-view-redis-deployment.yaml -n monitoring
```
deployment.apps/kube-ops-view-redis created
```
kubectl create -f kube-ops-view-service.yaml -n monitoring
```
service/kube-ops-view-redis created

```
kubectl create -f kube-ops-view-redis-service.yaml -n monitoring
```
service/kube-ops-view-redis created
```
kubectl get all -n monitoring
```
<pre>
NAME                                       READY   STATUS    RESTARTS   AGE
pod/kube-ops-view-7b47c5594d-mr9k2         1/1     Running   0          2m30s
pod/kube-ops-view-redis-7b7b586cf4-hqjq7   1/1     Running   0          2m


NAME                          TYPE           CLUSTER-IP     EXTERNAL-IP     PORT(S)        AGE
service/kube-ops-view         LoadBalancer   10.0.217.128   51.104.144.39   80:31994/TCP   105s
service/kube-ops-view-redis   ClusterIP      10.0.10.28     <none>          6379/TCP       97s


NAME                                  READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/kube-ops-view         1/1     1            1           2m30s
deployment.apps/kube-ops-view-redis   1/1     1            1           2m

NAME                                             DESIRED   CURRENT   READY   AGE
replicaset.apps/kube-ops-view-7b47c5594d         1         1         1       2m30s
replicaset.apps/kube-ops-view-redis-7b7b586cf4   1         1         1       2m
</pre>


