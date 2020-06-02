kubectl create ns hpa


kubectl config set-context --current --namespace=hpa

kubectl apply -f vote-deploy.yaml

kubectl apply -f vote-svc.yaml

kubectl apply -f vote-hpa.yaml

kubectl get hpa

kubectl describe hpa vote

kubectl get pod,deploy


kubectl apply -f loadtest-job.yaml

kubectl get pods -w

kubectl get jobs
kubectl describe  job loadtest

kubectl logs -l job-name=loadtest