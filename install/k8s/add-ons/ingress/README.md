Installing Ingress
```bash
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
```
```bash
kubectl create ns ingress
```
<pre>
namespace/ingress created
</pre>

#helm install myingress stable/nginx-ingress \
#    --namespace ingress \
#    --set controller.replicaCount=2 \
#    --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux \
#    --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux


helm install nginx-ingress stable/nginx-ingress \
    --namespace ingress \
    --set controller.replicaCount=2 \
    --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux \
    --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux \
    --set controller.service.loadBalancerIP="40.127.245.113" \
    --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-dns-label-name"="myingress"

helm list -n ingress

NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                   APP VERSION
nginx-ingress   ingress         1               2020-06-04 20:41:36.5757208 +0200 CEST  deployed        nginx-ingress-1.39.1    0.32.0

kubectl get all -n ingress


# Install the CustomResourceDefinition resources separately
kubectl apply --validate=false -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.13/deploy/manifests/00-crds.yaml

customresourcedefinition.apiextensions.k8s.io/certificaterequests.cert-manager.io created
customresourcedefinition.apiextensions.k8s.io/certificates.cert-manager.io created
customresourcedefinition.apiextensions.k8s.io/challenges.acme.cert-manager.io created
customresourcedefinition.apiextensions.k8s.io/clusterissuers.cert-manager.io created
customresourcedefinition.apiextensions.k8s.io/issuers.cert-manager.io created
customresourcedefinition.apiextensions.k8s.io/orders.acme.cert-manager.io created

# Label the cert-manager namespace to disable resource validation
kubectl label namespace ingress cert-manager.io/disable-validation=true
namespace/ingress labeled

# Add the Jetstack Helm repository
helm repo add jetstack https://charts.jetstack.io
"jetstack" has been added to your repositories
# Update your local Helm chart repository cache
helm repo update

# Install the cert-manager Helm chart
helm install \
  cert-manager \
  --namespace ingress \
  --version v0.13.0 \
  jetstack/cert-manager





$ helm list -n ingress
NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                   APP VERSION
cert-manager    ingress         1               2020-06-04 20:44:33.1537623 +0200 CEST  deployed        cert-manager-v0.13.0    v0.13.0
nginx-ingress   ingress         1               2020-06-04 20:41:36.5757208 +0200 CEST  deployed        nginx-ingress-1.39.1    0.32.0



kubectl apply -f cluster-issuer-staging.yaml --namespace ingress

kubectl apply -f cluster-issuer-prod.yaml --namespace ingress

kubectl apply -f aks-helloworld.yaml --namespace ingress
kubectl apply -f ingress-demo.yaml --namespace ingress

kubectl apply -f hello-world-ingress.yaml --namespace ingress


kubectl describe certificate tls-secret --namespace ingress


TODO adding static IP address for ingress

https://docs.microsoft.com/en-us/azure/aks/ingress-static-ip


https://docs.cert-manager.io/en/release-0.11/tutorials/acme/quick-start/index.html

