Installing Prometheus

```bash
helm repo add stable https://kubernetes-charts.storage.googleapis.com/

helm repo update

helm install myprometheus  stable/prometheus --namespace=monitoring \
--set=service.type=LoadBalancer --set=service.port=9100
```

```bash
kubectl get pod --namespace monitoring -l release=myprometheus -l component=server  
```
<pre>
NAME                                 READY   STATUS              RESTARTS   AGE
myprometheus-server-9845ccf9-9xkqq   0/2     ContainerCreating   0          16s
</pre>

```bash
helm list -n monitoring
```
<pre>
NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                   APP VERSION
myprometheus    monitoring      1               2020-06-04 23:22:58.4996371 +0200 CEST  deployed        prometheus-11.4.0       2.18.1
</pre>
```bash
kubectl get all -n monitoring
```
<pre>
NAME                                                   READY   STATUS    RESTARTS   AGE
pod/kube-ops-view-7b47c5594d-sdxsq                     1/1     Running   0          14m
pod/kube-ops-view-redis-7b7b586cf4-h9l7x               1/1     Running   0          14m
pod/myprometheus-alertmanager-5bb857974f-lnn5x         2/2     Running   0          8m6s
pod/myprometheus-kube-state-metrics-79c47c4886-jqtpx   1/1     Running   0          8m6s
pod/myprometheus-node-exporter-59j74                   1/1     Running   0          8m6s
pod/myprometheus-node-exporter-bfd5p                   1/1     Running   0          8m6s
pod/myprometheus-node-exporter-h56sd                   1/1     Running   0          8m6s
pod/myprometheus-pushgateway-78f9dcfbc6-fplkl          1/1     Running   0          8m6s
pod/myprometheus-server-9845ccf9-9xkqq                 2/2     Running   0          8m6s


NAME                                      TYPE           CLUSTER-IP     EXTERNAL-IP      PORT(S)        AGE
service/kube-ops-view                     LoadBalancer   10.0.124.138   40.127.239.249   80:30917/TCP   14m
service/kube-ops-view-redis               ClusterIP      10.0.169.42    <none>           6379/TCP       14m
service/myprometheus-alertmanager         ClusterIP      10.0.251.14    <none>           80/TCP         8m7s
service/myprometheus-kube-state-metrics   ClusterIP      10.0.250.168   <none>           8080/TCP       8m7s
service/myprometheus-node-exporter        ClusterIP      None           <none>           9100/TCP       8m7s
service/myprometheus-pushgateway          ClusterIP      10.0.120.211   <none>           9091/TCP       8m7s
service/myprometheus-server               ClusterIP      10.0.87.131    <none>           80/TCP         8m7s

NAME                                        DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
daemonset.apps/myprometheus-node-exporter   3         3         3       3            3           <none>          8m7s

NAME                                              READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/kube-ops-view                     1/1     1            1           14m
deployment.apps/kube-ops-view-redis               1/1     1            1           14m
deployment.apps/myprometheus-alertmanager         1/1     1            1           8m7s
deployment.apps/myprometheus-kube-state-metrics   1/1     1            1           8m7s
deployment.apps/myprometheus-pushgateway          1/1     1            1           8m7s
deployment.apps/myprometheus-server               1/1     1            1           8m7s

NAME                                                         DESIRED   CURRENT   READY   AGE
replicaset.apps/kube-ops-view-7b47c5594d                     1         1         1       14m
replicaset.apps/kube-ops-view-redis-7b7b586cf4               1         1         1       14m
replicaset.apps/myprometheus-alertmanager-5bb857974f         1         1         1       8m7s
replicaset.apps/myprometheus-kube-state-metrics-79c47c4886   1         1         1       8m7s
replicaset.apps/myprometheus-pushgateway-78f9dcfbc6          1         1         1       8m7s
replicaset.apps/myprometheus-server-9845ccf9                 1         1         1       8m7s
</pre>