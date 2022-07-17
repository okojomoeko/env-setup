#!/usr/bin/env bash
set -e
# BASE_IMAGE="registry"
# REGISTRY="registry.hub.docker.com"
IMAGE="okojo-devcontainer"
CID=$(docker ps -a --filter "name=$IMAGE" --filter "status=running"| grep $IMAGE | awk '{print $1}')

echo $CID

if [ -n "$CID" ]; then
  docker exec -u 0 $CID /bin/bash -c "sudo apt update; sudo apt upgrade -y; sudo -s eval $(ncu -u -g | tail -n 2)"

  docker commit $IMAGE $IMAGE:latest;
fi
