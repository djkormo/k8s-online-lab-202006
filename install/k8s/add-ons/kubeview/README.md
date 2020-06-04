kubectl create -f kubeview-rbac.yaml -n monitor

serviceaccount/kubeview created
clusterrole.rbac.authorization.k8s.io/kubeview created
clusterrolebinding.rbac.authorization.k8s.io/kubeview created



kubectl create -f kubeview-deployment.yaml -n monitor

deployment.apps/kubeview created

kubectl create -f kubeview-service.yaml -n monitor
