#!/bin/bash

# Arguments
# $1: create / replace / delete

# Create secrets
kubectl $1 -f secret/mysql-login.yaml
kubectl $1 -f secret/jwt.yaml
# kubectl $1 -f secret/mongo-login.yaml
kubectl $1 -f secret/useragent-api.yaml
kubectl $1 -f secret/google-maps.yaml

# Create deployments
kubectl $1 -f deployment/phpmyadmin-deployment.yaml
kubectl $1 -f deployment/dqc-api-deployment.yaml
kubectl $1 -f deployment/interactive-resume-and-url-shortener-deployment.yaml
kubectl $1 -f deployment/data-quality-checker-deployment.yaml
kubectl $1 -f deployment/slimphp-api-deployment.yaml
# kubectl $1 -f deployment/graphql-express-api-deployment.yaml
kubectl $1 -f deployment/analytics-for-links-and-sites-deployment.yaml

# Create ingresses
kubectl $1 -f ingress/kellenschmidtcom-ingress.yaml
# kubectl $1 -f ingress/kellenforthewin-ingress.yaml

# Create the issuer
kubectl $1 -f issuer/general-issuer.yaml

if [ "$1" == "create" ]; then
  currentTime=$(date +"%H:%M:%S")
  GREEN='\033[0;32m'
  ORANGE='\033[0;33m'
  NC='\033[0m'
  printf "${GREEN}\nkellenschmidt.com has been successfully deployed!\n"
  printf "${ORANGE}Please wait at least 10 minutes for all containers to finish starting up. (Started: ${currentTime})\n\n${NC}"
fi
