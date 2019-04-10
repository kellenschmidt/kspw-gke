# kspw-gke

```sh
sh bin/start_cluster.sh
sh bin/add_helm.sh
helm install stable/nginx-ingress --name quickstart
sh bin/add_cert_manager.sh
```

Get IP address and set domain name

```sh
kubectl get svc
kubectl get services | grep LoadBalancer | awk '{print $4}'
host kellenschmidt.com
# gcloud compute addresses create web-static-ip --global
```

```sh
sh bin/crd.sh create
```
