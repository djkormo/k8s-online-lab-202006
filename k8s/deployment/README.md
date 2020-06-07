
Creating a Deployment

A Deployment is a higher level abstraction which sits on top of replica sets and allows you to manage the way applications are deployed, rolled back at a controlled rate.



```bash
kubectl create namespace deploy
```
<pre>
namespace/deploy created
</pre>


```bash
kubectl config set-context --current --namespace=deploy
```
<pre>
Context "aks-simple2020" modified.
</pre>

```bash
kubectl apply -f deploy-php-hello.yaml
```
<pre>
deployment.apps/php-hello created
</pre>

```bash
kubectl get all
```
<pre>
NAME                            READY   STATUS    RESTARTS   AGE
pod/php-hello-974cdc5b9-55kqj   1/1     Running   0          39s
pod/php-hello-974cdc5b9-9jwsn   1/1     Running   0          39s
pod/php-hello-974cdc5b9-f6nvb   1/1     Running   0          39s
pod/php-hello-974cdc5b9-g4nq8   1/1     Running   0          39s
pod/php-hello-974cdc5b9-hc9f2   1/1     Running   0          39s
pod/php-hello-974cdc5b9-nnwrm   1/1     Running   0          39s
pod/php-hello-974cdc5b9-ttvk6   1/1     Running   0          39s
pod/php-hello-974cdc5b9-v5pf4   1/1     Running   0          39s

NAME                        READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/php-hello   8/8     8            8           39s

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/php-hello-974cdc5b9   8         8         8       39s
</pre>


```bash
kubectl get rs
```
<pre>
NAME                  DESIRED   CURRENT   READY   AGE
php-hello-974cdc5b9   8         8         8       114s
</pre>

```bash
kubectl get rs --show-labels
kubectl rollout status deployment/php-hello
kubectl get pods --show-labels
```

<pre>
NAME                  DESIRED   CURRENT   READY   AGE     LABELS
php-hello-974cdc5b9   8         8         8       3m57s   app=php-hello,pod-template-hash=974cdc5b9,role=web,version=v1

deployment "php-hello" successfully rolled out

NAME                        READY   STATUS    RESTARTS   AGE     LABELS
php-hello-974cdc5b9-55kqj   1/1     Running   0          4m19s   app=php-hello,pod-template-hash=974cdc5b9,role=web,version=v1
php-hello-974cdc5b9-9jwsn   1/1     Running   0          4m19s   app=php-hello,pod-template-hash=974cdc5b9,role=web,version=v1
php-hello-974cdc5b9-f6nvb   1/1     Running   0          4m19s   app=php-hello,pod-template-hash=974cdc5b9,role=web,version=v1
php-hello-974cdc5b9-g4nq8   1/1     Running   0          4m19s   app=php-hello,pod-template-hash=974cdc5b9,role=web,version=v1
php-hello-974cdc5b9-hc9f2   1/1     Running   0          4m19s   app=php-hello,pod-template-hash=974cdc5b9,role=web,version=v1
php-hello-974cdc5b9-nnwrm   1/1     Running   0          4m19s   app=php-hello,pod-template-hash=974cdc5b9,role=web,version=v1
php-hello-974cdc5b9-ttvk6   1/1     Running   0          4m19s   app=php-hello,pod-template-hash=974cdc5b9,role=web,version=v1
php-hello-974cdc5b9-v5pf4   1/1     Running   0          4m19s   app=php-hello,pod-template-hash=974cdc5b9,role=web,version=v1
</pre>


```bash
kubectl scale deployment/php-hello --replicas=12
kubectl rollout status deployment/php-hello
```
<pre>
deployment.apps/php-hello scaled

Waiting for deployment "php-hello" rollout to finish: 5 of 12 updated replicas are available...
deployment "php-hello" successfully rolled out
</pre>

```bash
kubectl rollout history deployment/php-hello
```
<pre>
deployment.apps/php-hello 
REVISION  CHANGE-CAUSE
1         <none>
</pre>

```bash
kubectl apply -f deploy-php-hello-2.yaml
```
deployment.apps/php-hello configured

```bash
kubectl rollout status deployment/php-hello
```
<pre>
Waiting for deployment "php-hello" rollout to finish: 3 out of 5 new replicas have been updated...
Waiting for deployment "php-hello" rollout to finish: 1 old replicas are pending termination...
deployment "php-hello" successfully rolled out
</pre>

```bash
kubectl get rs
```
<pre>
NAME                   DESIRED   CURRENT   READY   AGE
php-hello-54468bc764   5         5         5       100s
php-hello-974cdc5b9    0         0         0       13m
</pre>


Deployment has mainly two responsibilities,

    Provide Fault Tolerance: Maintain the number of replicas for a type of service/app. Schedule/delete pods to meet the desired count.
    Update Strategy: Define a release strategy and update the pods accordingly.


Deployment spec (deployment.spec) contains everything that replica set has + strategy. Lets add it as follows,


```bash
kubectl get deployments
```
<pre>
NAME       DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
vote   3         3         3            1           3m
</pre>


Scaling a deployment

To scale a deployment in Kubernetes:
```
kubectl scale deployment/php-hello --replicas=12

kubectl rollout status deployment/php-hello
```
Sample output:

<pre>
Waiting for deployment "php-hello" rollout to finish: 5 of 12 updated replicas are available...
deployment "php-hello" successfully rolled out
</pre>

You could also update the deployment by editing it.
```
kubectl edit deploy/vote
```
[change replicas to 15 from the editor, save and observe]
Rolling Updates in Action

Now, update the deployment spec to apply


```
kubectl apply -f deploy-php-hello-2.yaml

kubectl rollout status deployment/php-hello
```

Observe rollout status and monitoring screen.

```
kubectl rollout history deploy/php-hello

kubectl rollout history deploy/php-hello --revision=1

Undo and Rollback

```bash
kubectl apply -f deploy-php-hello.yaml
```

<pre>
deployment.apps/php-hello configured
</pre>

``
kubectl rollout status deploy/php-hello

kubectl rollout history deploy/php-hello

kubectl rollout history deploy/php-hello --revision=2
```

<pre>
Waiting for deployment "php-hello" rollout to finish: 3 out of 5 new replicas have been updated...
Waiting for deployment "php-hello" rollout to finish: 1 old replicas are pending termination...
deployment "php-hello" successfully rolled out

REVISION  CHANGE-CAUSE
2         <none>
3         <none>
4         <none>


deployment.apps/php-hello with revision #2
Pod Template:
  Labels:       app=php-hello
        pod-template-hash=54468bc764
        role=web
        version=v1
  Containers:
   app:
    Image:      djkormo/php-hello:v2
    Port:       80/TCP
    Host Port:  0/TCP
    Environment:        <none>
    Mounts:     <none>
  Volumes:      <none>

</pre>

```
where replace xxx with revisions

Find out the previous revision with sane configs.

To undo to a sane version (for example revision 3)

```
kubectl rollout undo deploy/php-hello --to-revision=3
```
<pre>
deployment.apps/php-hello rolled back
</pre>



Cleaning up resources

```
kubectl delete ns deploy
```

<pre>

</pre>