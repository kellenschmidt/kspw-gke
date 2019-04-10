# kspw-gke

New and improved K8s infrastructure used by kellenschmidt.com on Google Cloud Platform

## GCP Deployment

Start new cluster and add ingress controller and cert manager

```sh
sh bin/create_cluster.sh
sh bin/add_secure_helm.sh
helm install stable/nginx-ingress --name quickstart
sh bin/add_cert_manager.sh
```

Get IP address and set domain name

```sh
kubectl get svc | grep LoadBalancer | awk '{print $4}'
host kellenschmidt.com
```

Start secrets, deployments, services, ingresses, and issuers

```sh
sh bin/crd.sh create
```

## GCloud commands

### Connect kubectl

gcloud config set compute/zone us-east1-b
gcloud container clusters get-credentials kellen6-cluster

## Resources

- Helm installation on GKE
    - https://medium.com/google-cloud/install-secure-helm-in-gke-254d520061f7
    - https://github.com/jonbcampos/kubernetes-series/tree/master/helm/scripts

- Cert manager and NGINX ingress controller installation
    - https://github.com/jetstack/cert-manager/blob/master/docs/tutorials/acme/quick-start/index.rst
