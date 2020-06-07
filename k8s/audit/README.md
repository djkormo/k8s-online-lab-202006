https://github.com/aquasecurity/kube-bench

```bash
kubectl apply –f https://raw.githubusercontent.com/aquasecurity/kube-bench/master/job.yaml \
  -n default
```
```bash
kubectl logs kube-bench-jsnck -n default

```

https://github.com/cyberark/kubernetes-rbac-audit


Export RBAC Roles:
```bash
kubectl get roles --all-namespaces -o json > Roles.json
```

Export RBAC ClusterRoles:
```
kubectl get clusterroles -o json > clusterroles.json
```

Export RBAC RolesBindings:
```
kubectl get rolebindings --all-namespaces -o json > rolebindings.json
```

Export RBAC Cluster RolesBindings:
```
kubectl get clusterrolebindings -o json > clusterrolebindings.json
```

wget https://raw.githubusercontent.com/cyberark/kubernetes-rbac-audit/master/ExtensiveRoleCheck.py

python3 ExtensiveRoleCheck.py --clusterRole clusterroles.json  --role Roles.json --rolebindings rolebindings.json --cluseterolebindings clusterrolebindings.json

<pre>
[*] Started enumerating risky ClusterRoles:
[!][ClusterRole]→ cert-manager-cainjector Has permission to list secrets!
[!][ClusterRole]→ cert-manager-controller-certificates Has permission to list secrets!
[!][ClusterRole]→ cert-manager-controller-challenges Has permission to list secrets!
[!][ClusterRole]→ cert-manager-controller-challenges Has permission to create pods!
[!][ClusterRole]→ cert-manager-controller-challenges Has permission to list secrets!
[!][ClusterRole]→ cert-manager-controller-clusterissuers Has permission to list secrets!
[!][ClusterRole]→ cert-manager-controller-issuers Has permission to list secrets!
[!][ClusterRole]→ cert-manager-controller-orders Has permission to list secrets!
[!][ClusterRole]→ kubeview Has permission to list secrets!
</pre>
