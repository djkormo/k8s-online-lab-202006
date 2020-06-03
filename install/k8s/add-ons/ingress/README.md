Installing Ingress

helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

kubectl create ns ingress
namespace/ingress created

helm install myingress stable/nginx-ingress \
    --namespace ingress \
    --set controller.replicaCount=2 \
    --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux \
    --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux

helm list -n ingress    

kubectl get all -n ingress



TODO adding static IP address for ingress

https://docs.microsoft.com/en-us/azure/aks/ingress-static-ip