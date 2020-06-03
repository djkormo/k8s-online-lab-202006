Installing Grafana

helm repo add stable https://kubernetes-charts.storage.googleapis.com/

helm repo update

helm install mygrafana stable/grafana --namespace=monitoring \
    --set=adminUser=admin \
    --set=adminPassword=admin \
    --set=service.type=LoadBalancer  \
    --set=service.port=4444

helm list -n monitoring    


Use user and password given in helm chart (admin, admin) and change it !

In Grafana add data source, choose Prometheus, in URL put http://myprometheus-server:80


Literature:

https://blog.gojekengineering.com/diy-how-to-set-up-prometheus-and-ingress-on-kubernetes-d395248e2ba