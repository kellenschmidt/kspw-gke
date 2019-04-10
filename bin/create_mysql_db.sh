#!/usr/bin/env bash

echo "preparing..."
export INSTANCE_REGION=us-east1
export PROJECT_NAME=kellen2
export MACHINE_TYPE=db-f1-micro
export INSTANCE_NAME=${PROJECT_NAME}-db

echo "enable services"
gcloud services enable servicenetworking.googleapis.com
gcloud services enable sqladmin.googleapis.com
    
gcloud beta sql instances create ${INSTANCE_NAME} \
    --tier ${MACHINE_TYPE} \
    --region ${INSTANCE_REGION} \
    --network default

gcloud sql users set-password root --host=% --instance=${INSTANCE_NAME} --prompt-for-password
gcloud sql users create kellen --host=% --instance=${INSTANCE_NAME} --password=temp
gcloud sql users set-password kellen --host=% --instance=${INSTANCE_NAME} --prompt-for-password
