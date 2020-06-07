Exposing Application with a Service

Types of Services:

    ClusterIP
    NodePort
    LoadBalancer
    ExternalName



```bash
kubectl create namespace services
```
<pre>
namespace/services created
</pre>


```bash
kubectl config set-context --current --namespace=services
```
<pre>
Context "aks-simple2020" modified.
</pre>


kubectl apply -f deploy-php-hello.yaml 

deployment.apps/php-hello created


kubectl apply -f service-php-hello.yaml 

kubernetes service

```bash 
kubectl apply -f service-php-hello.yaml
```
<pre>
service/php-hello created
</pre>

```bash
kubectl get svc
```
<pre>
NAME        TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
php-hello   NodePort   10.0.162.194   <none>        80:30000/TCP   101s
</pre>

```
kubectl describe svc
```
<pre>
Name:                     php-hello
Namespace:                services
Labels:                   role=web
Annotations:              kubectl.kubernetes.io/last-applied-configuration:
                            {"apiVersion":"v1","kind":"Service","metadata":{"annotations":{},"labels":{"role":"web"},"name":"php-hello","namespace":"services"},"spec"...
Selector:                 role=web
Type:                     NodePort
IP:                       10.0.162.194
Port:                     <unset>  80/TCP
TargetPort:               80/TCP
NodePort:                 <unset>  30000/TCP
Endpoints:                10.240.0.17:80,10.240.0.22:80,10.240.0.37:80 + 5 more...
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>
</pre>

```bash
kubectl get endpoints
```
<pre>
NAME        ENDPOINTS                                                  AGE
php-hello   10.240.0.17:80,10.240.0.22:80,10.240.0.37:80 + 5 more...   2m35s
</pre>

```bash
kubectl describe endpoints
```
<pre>
Name:         php-hello
Namespace:    services
Labels:       role=web
Annotations:  endpoints.kubernetes.io/last-change-trigger-time: 2020-06-07T16:24:56Z
Subsets:
  Addresses:          10.240.0.17,10.240.0.22,10.240.0.37,10.240.0.42,10.240.0.50,10.240.0.82,10.240.0.90,10.240.0.95
  NotReadyAddresses:  <none>
  Ports:
    Name     Port  Protocol
    ----     ----  --------
    <unset>  80    TCP

Events:  <none>
</pre>



kubectl port-forward svc/php-hello 8080:80
Forwarding from 127.0.0.1:8080 -> 80
Forwarding from [::1]:8080 -> 80

Browse at

http://localhost:8080/


<pre>
Hello, World from Docker!

Displayed at: php-hello-974cdc5b9-bp4lm
Application version : 1.0 !
</pre>


```bash 
kubectl apply -f service-php-hello-loadbalancer.yaml
```
<pre>
service/php-hello-loadbalancer created
</pre>

```bash
kubectl get svc
```
<pre>
NAME                     TYPE           CLUSTER-IP     EXTERNAL-IP    PORT(S)        AGE
php-hello                NodePort       10.0.162.194   <none>         80:30000/TCP   79m
php-hello-loadbalancer   LoadBalancer   10.0.246.185   20.191.47.55   80:32668/TCP   9m30s
</pre>

Browse at http://20.191.47.55:80


kubectl run -i --tty dnsutils --image=gcr.io/kubernetes-e2e-test-images/dnsutils --restart=Never -- sh   


