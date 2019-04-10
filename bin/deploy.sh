#!/bin/bash

# Arguments
# $1: DOCKER_USER
# $2: CIRCLE_PROJECT_REPONAME
# $3: Deployment name

# If $3 is unset use $2, else use $3
if [ -z ${3+x} ]; then
  deployment=$2
else
  deployment=$3
fi

docker_hub_token=$(curl "https://auth.docker.io/token?service=registry.docker.io&scope=repository:$1/$2:pull" | jq -r '.token')
tag=$(curl -H "Authorization: Bearer $docker_hub_token" https://registry.hub.docker.com/v2/$1/$2/tags/list | jq '."tags"[]' | sort -V | tail -1 | sed -e 's/^"//' -e 's/"$//')

date=$(date +"%d-%m-%Y_%H:%M:%S")
echo "Deploy initiated | deployment/$deployment $2=$1/$2:$tag | $date" >> /tmp/deploy_log.txt

kubectl set image deployment/$deployment $2=$1/$2:$tag
