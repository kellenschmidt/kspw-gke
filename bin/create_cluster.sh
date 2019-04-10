#!/usr/bin/env bash

# Taken from https://github.com/jonbcampos/kubernetes-series/blob/master/helm/scripts/startup.sh

echo "preparing..."
export GCLOUD_PROJECT=$(gcloud config get-value project)
# export INSTANCE_REGION=us-west1
# export INSTANCE_REGION=us-central1
export INSTANCE_REGION=us-east1
export INSTANCE_ZONE=${INSTANCE_REGION}-b
export PROJECT_NAME=kellen6
export MACHINE_TYPE=g1-small
# export MACHINE_TYPE=f1-micro # f1-micro requires at least 3 nodes
export CLUSTER_NAME=${PROJECT_NAME}-cluster
export CONTAINER_NAME=${PROJECT_NAME}-container
export NUM_NODES=3
export CLUSTER_VERSION=1.12.6-gke.10

echo "setup"
gcloud config set compute/zone ${INSTANCE_ZONE}

echo "enable services"
gcloud services enable compute.googleapis.com
gcloud services enable container.googleapis.com

echo "creating container engine cluster"
gcloud container clusters create ${CLUSTER_NAME} \
    --preemptible \
    --machine-type ${MACHINE_TYPE} \
    --zone ${INSTANCE_ZONE} \
    --scopes cloud-platform \
    --enable-autorepair \
    --enable-autoupgrade \
    --enable-ip-alias \
    --num-nodes ${NUM_NODES} \
    --cluster-version ${CLUSTER_VERSION}

echo "confirm cluster is running"
gcloud container clusters list

echo "get credentials"
gcloud container clusters get-credentials ${CLUSTER_NAME} \
    --zone ${INSTANCE_ZONE}

echo "confirm connection to cluster"
kubectl cluster-info

echo "create cluster administrator"
kubectl create clusterrolebinding cluster-admin-binding \
    --clusterrole=cluster-admin --user=$(gcloud config get-value account)

echo "confirm the pod is running"
kubectl get pods

echo "list production services"
kubectl get svc

echo "enable services"
gcloud services enable cloudbuild.googleapis.com
