
Installing kubeview from helm chart
```bash
helm repo add cowboysysop https://cowboysysop.github.io/charts/

helm repo update

helm install kubeview cowboysysop/kubeview --version 1.2.0 \
  --namespace=monitoring --set=service.type=LoadBalancer  \
  --set=service.port=3333
```

<pre>
NAME: kubeview
LAST DEPLOYED: Sat Jun  6 20:18:08 2020
NAMESPACE: monitoring
STATUS: deployed
REVISION: 1
NOTES:
1. Get the application URL by running these commands:
     NOTE: It may take a few minutes for the LoadBalancer IP to be available.
           You can watch the status of by running 'kubectl get --namespace monitoring svc -w kubeview'
  export SERVICE_IP=$(kubectl get svc --namespace monitoring kubeview --template "{{ range (index .status.loadBalancer.ingress 0) }}{{.}}{{ end }}")
  echo http://$SERVICE_IP:3333
</pre>  

