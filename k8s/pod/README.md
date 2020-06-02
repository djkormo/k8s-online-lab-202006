```yaml
apiVersion: v1
kind: Pod
metadata:
  name: vote
  labels:
    app: python
    role: vote
    version: v1
spec:
  containers:
    - name: app
      image: schoolofdevops/vote:v1
```
```console
kubectl apply -f vote-pod.yaml
```

```console
kubectl get pods

kubectl get po -o wide

kubectl get pods vote
```

```console
kubectl describe pods vote

kubectl logs vote

kubectl exec -it vote  sh
```

ifconfig
cat /etc/issue
hostname
cat /proc/cpuinfo
ps aux

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: db
  labels:
    app: postgres
    role: database
    tier: back
spec:
  containers:
    - name: db
      image: postgres:9.4
      ports:
        - containerPort: 5432
      volumeMounts:
      - name: db-data
        mountPath: /var/lib/postgresql/data
  volumes:
  - name: db-data
    hostPath:
      path: /var/lib/pgdata
      type: DirectoryOrCreate
```


To create this pod

```console
kubectl apply -f db-pod.yaml

kubectl describe pod db

kubectl get events
```


```yaml
apiVersion: v1
kind: Pod
metadata:
  name: web
  labels:
    tier: front
    app: nginx
    role: ui
spec:
  containers:
    - name: nginx
      image: nginx:stable-alpine
      ports:
        - containerPort: 80
          protocol: TCP
      volumeMounts:
        - name: data
          mountPath: /var/www/html-sample-app

    - name: sync
      image: schoolofdevops/sync:v2
      volumeMounts:
        - name: data
          mountPath: /var/www/app

  volumes:
    - name: data
      emptyDir: {}
```
To create this pod
```console
kubectl apply -f multi_container_pod.yml
```
Check Status
```
kubectl get pods
```
NAME      READY     STATUS              RESTARTS   AGE
nginx     0/2       ContainerCreating   0          7s
vote      1/1       Running             0          3m

Checking logs, logging in

```console
kubectl logs  web  -c sync
kubectl logs  web  -c nginx
```

```console
kubectl exec -it web  sh  -c nginx
kubectl exec -it web  sh  -c sync
```
Observe whats common and whats isolated in two containers running inside the same pod using the following commands,

```bash
shared

hostname
ifconfig

isolated

cat /etc/issue
ps aux
df -h
```
