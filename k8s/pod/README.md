
```bash 
kubectl create ns pod
```
<pre>
namespace/pod created
</pre>
```bash
kubectl config set-context --current --namespace=pod
```

<pre>
Context "aks-simple2020" modified.
</pre>


```yaml chess-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: chess
  labels:
    name: chess
spec:
  containers:
  - name: chess
    image: djkormo/chess-ai
    ports:
      - containerPort: 80

```


```bash

kubectl apply -f chess-pod.yaml

```
<pre>
pod/chess created
</pre>

```bash
kubectl get pods
kubectl get po -o wide
kubectl get pods chess
```

<pre>
NAME    READY   STATUS    RESTARTS   AGE
chess   1/1     Running   0          97s

$ kubectl get po -o wide
NAME    READY   STATUS    RESTARTS   AGE   IP            NODE                       NOMINATED NODE   READINESS GATES
chess   1/1     Running   0          98s   10.240.0.91   aks-nodepool1-69931308-1   <none>           <none>

$ kubectl get pods chess
NAME    READY   STATUS    RESTARTS   AGE
chess   1/1     Running   0          99s
</pre>


```bash
kubectl describe pods chess

```

<pre>
Name:         chess
Namespace:    pod
Priority:     0
Node:         aks-nodepool1-69931308-1/10.240.0.66
Start Time:   Sun, 07 Jun 2020 13:17:02 +0200     
Labels:       name=chess
Annotations:  kubectl.kubernetes.io/last-applied-configuration:
                {"apiVersion":"v1","kind":"Pod","metadata":{"annotations":{},"labels":{"name":"chess"},"name":"chess","namespace":"pod"},"spec":{"containe...
Status:       Running
IP:           10.240.0.91
Containers:
  chess:
    Container ID:   docker://8d9758e10018e3f0be22d1f6181d89b3797eb13725be0aaec70d83ba3abd840f
    Image:          djkormo/chess-ai
    Image ID:       docker-pullable://djkormo/chess-ai@sha256:675eec3ecf3c731d1ff9fdc1b11114a932180983b2c820199b482f134547ed75
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Sun, 07 Jun 2020 13:17:12 +0200
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-2grwn (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  default-token-2grwn:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-2grwn
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type    Reason     Age    From                               Message
  ----    ------     ----   ----                               -------
  Normal  Scheduled  3m19s  default-scheduler                  Successfully assigned pod/chess to aks-nodepool1-69931308-1
  Normal  Pulling    3m18s  kubelet, aks-nodepool1-69931308-1  Pulling image "djkormo/chess-ai"
  Normal  Pulled     3m14s  kubelet, aks-nodepool1-69931308-1  Successfully pulled image "djkormo/chess-ai"
  Normal  Created    3m9s   kubelet, aks-nodepool1-69931308-1  Created container chess
  Normal  Started    3m9s   kubelet, aks-nodepool1-69931308-1  Started container chess
</pre>

```bash
kubectl logs chess
```

<pre>

</pre>


```kubectl port-forward pod/chess 8080:80
```
<pre>
Forwarding from 127.0.0.1:8080 -> 80
Forwarding from [::1]:8080 -> 80
</pre>

Use http://localhost:8080/ at your local browser

```bash
kubectl logs chess
```
<pre>
 NT 10.0; Win64; x64; rv:76.0) Gecko/20100101 Firefox/76.0"
127.0.0.1 - - [07/Jun/2020:11:23:47 +0000] "GET /img/chesspieces/wikipedia/wR.png HTTP/1.1" 304 - "http://localhost:8080/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101 Firefox/76.0"
127.0.0.1 - - [07/Jun/2020:11:23:47 +0000] "GET /img/chesspieces/wikipedia/wN.png HTTP/1.1" 304 - "http://localhost:8080/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101 Firefox/76.0"
127.0.0.1 - - [07/Jun/2020:11:23:47 +0000] "GET /img/chesspieces/wikipedia/wB.png HTTP/1.1" 304 - "http://localhost:8080/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101 Firefox/76.0"
127.0.0.1 - - [07/Jun/2020:11:23:47 +0000] "GET /img/chesspieces/wikipedia/wQ.png HTTP/1.1" 304 - "http://localhost:8080/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101 Firefox/76.0"
127.0.0.1 - - [07/Jun/2020:11:23:47 +0000] "GET /img/chesspieces/wikipedia/wK.png HTTP/1.1" 304 - "http://localhost:8080/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101 Firefox/76.0"
</pre>

```bash
kubectl exec -it chess  sh
```
<pre>
/ # whoami
root
/ # uname -a
Linux chess 4.15.0-1083-azure #93~16.04.1-Ubuntu SMP Thu May 7 18:39:44 UTC 2020 x86_64 Linux
/ # hostname
chess
/ # ps
PID   USER     TIME  COMMAND
    1 root      0:00 httpd -D FOREGROUND
    7 apache    0:00 httpd -D FOREGROUND
    8 apache    0:00 httpd -D FOREGROUND
    9 apache    0:00 httpd -D FOREGROUND
   10 apache    0:00 httpd -D FOREGROUND
   11 apache    0:00 httpd -D FOREGROUND
   19 apache    0:00 httpd -D FOREGROUND
   20 apache    0:00 httpd -D FOREGROUND
   21 apache    0:00 httpd -D FOREGROUND
   22 apache    0:00 httpd -D FOREGROUND
   23 apache    0:00 httpd -D FOREGROUND
   24 apache    0:00 httpd -D FOREGROUND
   25 apache    0:00 httpd -D FOREGROUND
   26 root      0:00 sh
   36 root      0:00 ps
/ # ifconfig
eth0      Link encap:Ethernet  HWaddr 2A:73:DE:79:CE:9E  
          inet addr:10.240.0.91  Bcast:0.0.0.0  Mask:255.255.0.0
          UP BROADCAST RUNNING  MTU:1500  Metric:1
          RX packets:5 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:446 (446.0 B)  TX bytes:0 (0.0 B)

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:173 errors:0 dropped:0 overruns:0 frame:0
          TX packets:173 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:259012 (252.9 KiB)  TX bytes:259012 (252.9 KiB)

/ # cat /etc/issue
Welcome to Alpine Linux 3.8
Kernel \r on an \m (\l)

/ # cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 79
model name      : Intel(R) Xeon(R) CPU E5-2673 v4 @ 2.30GHz
stepping        : 1
microcode       : 0xffffffff
cpu MHz         : 2294.690
cache size      : 51200 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 20
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ss ht syscall nx pdpe1gb rdtscp lm constant_tsc rep_good nopl xtopology cpuid pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single pti fsgsbase bmi1 hle avx2 smep bmi2 erms invpcid rtm rdseed adx smap xsaveopt md_clear
bugs            : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapgs taa itlb_multihit
bogomips        : 4589.38
clflush size    : 64
cache_alignment : 64
address sizes   : 44 bits physical, 48 bits virtual
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 79
model name      : Intel(R) Xeon(R) CPU E5-2673 v4 @ 2.30GHz
stepping        : 1
microcode       : 0xffffffff
cpu MHz         : 2294.690
cache size      : 51200 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
apicid          : 1
initial apicid  : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 20
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ss ht syscall nx pdpe1gb rdtscp lm constant_tsc rep_good nopl xtopology cpuid pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single pti fsgsbase bmi1 hle avx2 smep bmi2 erms invpcid rtm rdseed adx smap xsaveopt md_clear
bugs            : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapgs taa itlb_multihit
bogomips        : 4589.38
clflush size    : 64
cache_alignment : 64
address sizes   : 44 bits physical, 48 bits virtual
power management:   
/ # 
</pre>


```console
kubectl apply -f vote-pod.yaml
```

```console
kubectl get pods

kubectl get po -o wide

kubectl get pods vote
```

Two containers in one two

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: web-app
  labels:
    project: k8spatterns
    pattern: Sidecar
spec:
  containers:
    # Main container is a stock httpd serving from /var/www/html
  - name: app
    image: centos/httpd
    ports:
      - containerPort: 80
    volumeMounts:
    - mountPath: /var/www/html
      name: git
    # Sidecar poll every 10 minutes a given repository with git
  - name: poll
    image: axeclbr/git
    volumeMounts:
    - mountPath: /var/lib/data
      name: git
    env:
      - name: GIT_REPO
        value: https://github.com/rhuss/beginner-html-site-scripted
    command:
    - "sh"
    - "-c"
    - "git clone $(GIT_REPO) . && watch -n 60 git pull"
    workingDir: /var/lib/data
  volumes:
  # The shared directory for holding the files
  - emptyDir: {}
    name: git
```
To create this pod
```console
kubectl apply -f web-app-pod-sidecar.yaml
```
Check Status
```
kubectl get pods
```
NAME      READY   STATUS              RESTARTS   AGE
chess     1/1     Running             0          15m
web-app   0/2     ContainerCreating   0          10s

Checking logs, logging in

```console
kubectl logs  web-app  -c poll
kubectl logs  web-app  -c app
```
poll
<pre>
Every 60s: git pull                                         2020-06-07 11:32:30

Already up-to-date.
</pre>
app
</pre>
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 10.240.0.79. Set the 'ServerName' directive globally to suppress this message
</pre>

```bash
kubectl port-forward pod/web-app 8080:80 
```

<pre>
Forwarding from 127.0.0.1:8080 -> 80
Forwarding from [::1]:8080 -> 80
</pre>

Use http://localhost:8080/ at your local browser


kubectl describe pod/web-app 


<pre>
ame:         web-app
Namespace:    pod
Priority:     0
Node:         aks-nodepool1-69931308-1/10.240.0.66
Start Time:   Sun, 07 Jun 2020 13:31:55 +0200
Labels:       pattern=Sidecar
              project=k8spatterns
Annotations:  kubectl.kubernetes.io/last-applied-configuration:
                {"apiVersion":"v1","kind":"Pod","metadata":{"annotations":{},"labels":{"pattern":"Sidecar","project":"k8spatterns"},"name":"web-app","name...
Status:       Running
IP:           10.240.0.79
Containers:
  app:
    Container ID:   docker://86f9c010d7bf1ff4dc846fcda339dffcc155b87952beff5da7f22ff501c11332
    Image:          centos/httpd
    Image ID:       docker-pullable://centos/httpd@sha256:26c6674463ff3b8529874b17f8bb55d21a0dcf86e025eafb3c9eeee15ee4f369
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Sun, 07 Jun 2020 13:32:23 +0200
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-2grwn (ro)
      /var/www/html from git (rw)
  poll:
    Container ID:  docker://6674f6c696cde3ed5bf111facd996f768efdff418b68e9a637cea155ace49967
    Image:         axeclbr/git
    Image ID:      docker-pullable://axeclbr/git@sha256:286e30f0285081d142e72442312a827a128c88247a4662174830c87d2d5b4434
    Port:          <none>
    Host Port:     <none>
    Command:
      sh
      -c
      git clone $(GIT_REPO) . && watch -n 60 git pull
    State:          Running
      Started:      Sun, 07 Jun 2020 13:32:28 +0200
    Ready:          True
    Restart Count:  0
    Environment:
      GIT_REPO:  https://github.com/rhuss/beginner-html-site-scripted
    Mounts:
      /var/lib/data from git (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-2grwn (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  git:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:
    SizeLimit:  <unset>
  default-token-2grwn:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-2grwn
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type    Reason     Age    From                               Message
  ----    ------     ----   ----                               -------
  Normal  Scheduled  7m57s  default-scheduler                  Successfully assigned pod/web-app to aks-nodepool1-69931308-1
  Normal  Pulling    7m56s  kubelet, aks-nodepool1-69931308-1  Pulling image "centos/httpd"
  Normal  Pulled     7m38s  kubelet, aks-nodepool1-69931308-1  Successfully pulled image "centos/httpd"
  Normal  Created    7m29s  kubelet, aks-nodepool1-69931308-1  Created container app
  Normal  Started    7m29s  kubelet, aks-nodepool1-69931308-1  Started container app
  Normal  Pulling    7m29s  kubelet, aks-nodepool1-69931308-1  Pulling image "axeclbr/git"
  Normal  Pulled     7m26s  kubelet, aks-nodepool1-69931308-1  Successfully pulled image "axeclbr/git"
  Normal  Created    7m24s  kubelet, aks-nodepool1-69931308-1  Created container poll
  Normal  Started    7m24s  kubelet, aks-nodepool1-69931308-1  Started container poll
</pre>


Cleaning up

```bash
kubectl delete ns pod
```

<pre>
namespace "pod" deleted
</pre>