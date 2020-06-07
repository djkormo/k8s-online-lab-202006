
Making application high available with Replication Controllers


```bash
kubectl create namespace rs
```
<pre>
namespace/rs created
</pre>


```bash
kubectl config set-context --current --namespace=rs
```
<pre>
Context "aks-simple2020" modified.
</pre>

```bash
kubectl create -f replicaset-php.yaml
```

<pre>
replicaset.apps/php-hello created
</pre>

```bash
kubectl get rs
```

<pre>
NAME        DESIRED   CURRENT   READY   AGE
php-hello   5         5         5       7s 
</pre>

```bash
kubectl describe rs php-hello
```
<pre>
Name:         php-hello
Namespace:    rs
Selector:     role=web,version in (v1,v2,v3)
Labels:       <none>
Annotations:  <none>
Replicas:     5 current / 5 desired
Pods Status:  5 Running / 0 Waiting / 0 Succeeded / 0 Failed
Pod Template:
  Labels:  app=php-hello
           role=web
           version=v1
  Containers:
   php-hello:
    Image:      djkormo/php-hello:v1
    Port:       80/TCP
    Host Port:  0/TCP
    Environment:
      VERSION:  1.0
    Mounts:     <none>
  Volumes:      <none>
Events:
  Type    Reason            Age   From                   Message
  ----    ------            ----  ----                   -------
  Normal  SuccessfulCreate  32s   replicaset-controller  Created pod: php-hello-nqw6k
  Normal  SuccessfulCreate  32s   replicaset-controller  Created pod: php-hello-44hn4
  Normal  SuccessfulCreate  32s   replicaset-controller  Created pod: php-hello-2nr8b
  Normal  SuccessfulCreate  32s   replicaset-controller  Created pod: php-hello-zh55r
  Normal  SuccessfulCreate  32s   replicaset-controller  Created pod: php-hello-6bl2z
</pre>

```bash
kubectl get all 
```
<pre>
NAME                  READY   STATUS    RESTARTS   AGE
pod/php-hello-2nr8b   1/1     Running   0          51s
pod/php-hello-44hn4   1/1     Running   0          51s
pod/php-hello-6bl2z   1/1     Running   0          51s
pod/php-hello-nqw6k   1/1     Running   0          51s
pod/php-hello-zh55r   1/1     Running   0          51s

NAME                        DESIRED   CURRENT   READY   AGE
replicaset.apps/php-hello   5         5         5       51s
</pre>

```bash
kubectl get pods --show-labels
```
<pre>
NAME              READY   STATUS    RESTARTS   AGE   LABELS
php-hello-2nr8b   1/1     Running   0          84s   app=php-hello,role=web,version=v1
php-hello-44hn4   1/1     Running   0          84s   app=php-hello,role=web,version=v1
php-hello-6bl2z   1/1     Running   0          84s   app=php-hello,role=web,version=v1
php-hello-nqw6k   1/1     Running   0          84s   app=php-hello,role=web,version=v1
php-hello-zh55r   1/1     Running   0          84s   app=php-hello,role=web,version=v1
</pre>

kubectl edit rs/php-hello


```bash
kubectl apply -f replicaset-php-2.yaml
```
<pre>
replicaset.apps/php-hello-2 created
</pre>

```bash
kubectl get rs
```
<pre>
NAME          DESIRED   CURRENT   READY   AGE
php-hello     5         5         5       45m
php-hello-2   5         5         5       37s
</pre>

```bash
kubectl apply -f replicaset-php-3.yaml
```

<pre>
replicaset.apps/php-hello-3 created
</pre>


```bash
kubectl get rs
```
<pre>
NAME          DESIRED   CURRENT   READY   AGE
php-hello     5         5         5       48m
php-hello-2   5         5         5       3m18s
php-hello-3   5         5         5       92s
</pre>

```bash
kubectl get pods --show-labels  
```
<pre>
NAME                READY   STATUS    RESTARTS   AGE     LABELS
php-hello-2-66m98   1/1     Running   0          4m52s   app=php-hello,role=web,version=v2
php-hello-2-8q478   1/1     Running   0          4m52s   app=php-hello,role=web,version=v2
php-hello-2-d7hn5   1/1     Running   0          4m52s   app=php-hello,role=web,version=v2
php-hello-2-hjxxg   1/1     Running   0          4m52s   app=php-hello,role=web,version=v2
php-hello-2-wr4h2   1/1     Running   0          4m52s   app=php-hello,role=web,version=v2
php-hello-3-c89ht   1/1     Running   0          3m6s    app=php-hello,role=web,version=v3
php-hello-3-dmn62   1/1     Running   0          3m6s    app=php-hello,role=web,version=v3
php-hello-3-fdqgg   1/1     Running   0          3m6s    app=php-hello,role=web,version=v3
php-hello-3-nvzcf   1/1     Running   0          3m6s    app=php-hello,role=web,version=v3
php-hello-3-qtv85   1/1     Running   0          3m6s    app=php-hello,role=web,version=v3
php-hello-92r48     1/1     Running   0          49m     app=php-hello,role=web,version=v1
php-hello-bx2xc     1/1     Running   0          49m     app=php-hello,role=web,version=v1
php-hello-g5d96     1/1     Running   0          49m     app=php-hello,role=web,version=v1
php-hello-lvg2w     1/1     Running   0          49m     app=php-hello,role=web,version=v1
php-hello-zg28m     1/1     Running   0          49m     app=php-hello,role=web,version=v1
</pre>

```bash
kubectl scale rs/php-hello  --replicas=3
kubectl scale rs/php-hello-2  --replicas=4
```
<pre>
replicaset.apps/php-hello scaled
replicaset.apps/php-hello-2 scaled
</pre>

```bash
kubectl get rs
```
<pre>
NAME          DESIRED   CURRENT   READY   AGE
php-hello     3         3         3       52m
php-hello-2   4         4         4       7m42s
php-hello-3   5         5         5       5m56s
</pre>

How to remove pods without definition ?

```
kubectl scale rs/php-hello-3  --replicas=0
```
<pre>
replicaset.apps/php-hello-3 scaled
</pre>

```bash
kubectl get rs 
```
<pre>
NAME          DESIRED   CURRENT   READY   AGE
php-hello     3         3         3       2m21s
php-hello-2   4         4         4       2m3s
php-hello-3   0         0         0       109s
</pre>

Cleaning up resources

```bash
kubectl delete ns rs
```
<pre>
namespace "rs" deleted
</pre>


