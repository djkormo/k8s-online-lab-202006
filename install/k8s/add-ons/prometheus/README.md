Installing Prometheus

helm repo add stable https://kubernetes-charts.storage.googleapis.com/

helm repo update

helm install myprometheus  stable/prometheus --namespace=monitoring \
--set=service.type=LoadBalancer --set=service.port=9100

kubectl get pod --namespace monitoring -l release=myprometheus -l component=server  

helm list -n monitoring

