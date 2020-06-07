```
kubectl create ns hpa
```
namespace/hpa created
```
kubectl config set-context --current --namespace=hpa
```
Context "aks-simple2020" modified.

```
kubectl apply -f vote-deploy.yaml
```
<pre>
deployment.apps/vote created
</pre>

```
kubectl apply -f vote-svc.yaml
```
service/vote created


```yaml 
apiVersion: autoscaling/v1
kind: HorizontalPodAutoscaler
metadata:
  name: vote
spec:
  minReplicas: 4
  maxReplicas: 15
  targetCPUUtilizationPercentage: 40
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: vote
```

```bash
kubectl apply -f vote-hpa.yaml
```
<pre>
horizontalpodautoscaler.autoscaling/vote created
</pre>

```bash
kubectl get hpa
```
<pre>
NAME   REFERENCE         TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
vote   Deployment/vote   1%/40%    4         15        8          69s
</pre>

```bash
kubectl describe hpa vote
```
<pre>
Name:                                                  vote
Namespace:                                             hpa
Labels:                                                <none>
Annotations:                                           kubectl.kubernetes.io/last-applied-configuration:
                                                         {"apiVersion":"autoscaling/v1","kind":"HorizontalPodAutoscaler","metadata":{"annotations":{},"name":"vote","namespace":"hpa"},"spec":{"max...
CreationTimestamp:                                     Sun, 07 Jun 2020 20:25:14 +0200
Reference:                                             Deployment/vote
Metrics:                                               ( current / target )
  resource cpu on pods  (as a percentage of request):  1% (1m) / 40%
Min replicas:                                          4
Max replicas:                                          15
Deployment pods:                                       8 current / 8 desired
Conditions:
  Type            Status  Reason               Message
  ----            ------  ------               -------
  AbleToScale     True    ScaleDownStabilized  recent recommendations were higher than current one, applying the highest recent recommendation  
  ScalingActive   True    ValidMetricFound     the HPA was able to successfully calculate a replica count from cpu resource utilization (percentage of request)
  ScalingLimited  False   DesiredWithinRange   the desired count is within the acceptable range
Events:           <none>
</pre>
```bash
kubectl get pod,deploy,svc
```
<pre>
NAME                        READY   STATUS    RESTARTS   AGE
pod/vote-7c98c98c46-bs7tl   1/1     Running   0          72s
pod/vote-7c98c98c46-j9xft   1/1     Running   0          72s
pod/vote-7c98c98c46-mxfz6   1/1     Running   0          72s
pod/vote-7c98c98c46-pkr7c   1/1     Running   0          72s
pod/vote-7c98c98c46-t4bjz   1/1     Running   0          72s
pod/vote-7c98c98c46-vvzrj   1/1     Running   0          72s
pod/vote-7c98c98c46-z5m97   1/1     Running   0          72s
pod/vote-7c98c98c46-zbvxx   1/1     Running   0          72s

NAME                   READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/vote   8/8     8            8           72s

NAME           TYPE       CLUSTER-IP   EXTERNAL-IP   PORT(S)        AGE
service/vote   NodePort   10.0.80.69   <none>        80:31000/TCP   39s
</pre>
```bash
kubectl apply -f loadtest-job.yaml
```
<pre>
job.batch/loadtest created
</pre>
```bash
kubectl get pods -w
```

```bash
kubectl get hpa
```
<pre>
NAME   REFERENCE         TARGETS    MINPODS   MAXPODS   REPLICAS   AGE
vote   Deployment/vote   181%/40%   4         15        15         12m
</pre>

```bash
kubectl get jobs
```
<pre>
NAME       COMPLETIONS   DURATION   AGE
loadtest   0/1           2m19s      2m19s
</pre>

```bash
kubectl describe  job loadtest
```

<pre>
Name:           loadtest
Namespace:      hpa
Selector:       controller-uid=19b45908-3be2-4a86-ab09-428a2c73e5f8
Labels:         app=loadtest
Annotations:    kubectl.kubernetes.io/last-applied-configuration:
                  {"apiVersion":"batch/v1","kind":"Job","metadata":{"annotations":{},"labels":{"app":"loadtest"},"name":"loadtest","namespace":"hpa"},"spec"...
Parallelism:    1
Completions:    1
Start Time:     Sun, 07 Jun 2020 20:36:24 +0200
Pods Statuses:  1 Running / 0 Succeeded / 0 Failed
Pod Template:
  Labels:  controller-uid=19b45908-3be2-4a86-ab09-428a2c73e5f8
           job-name=loadtest
  Containers:
   siege:
    Image:      schoolofdevops/loadtest:v1
    Port:       <none>
    Host Port:  <none>
    Command:
      siege
      --concurrent=5
      --benchmark
      --time=5m
      http://vote
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Events:
  Type    Reason            Age    From            Message
  ----    ------            ----   ----            -------
  Normal  SuccessfulCreate  2m39s  job-controller  Created pod: loadtest-np86z
</pre>

```bash
kubectl logs -l job-name=loadtest
```
<pre>
Concurrency:                    4.97
Successful transactions:      183460
Failed transactions:             191
Longest transaction:            2.47
Shortest transaction:           0.00
 
FILE: /var/log/siege.log
You can disable this annoying message by editing
the .siegerc file in your home directory; change
the directive 'show-logfile' to false.
</pre>