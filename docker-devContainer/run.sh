#!/usr/bin/env bash
set -e
# BASE_IMAGE="registry"
# REGISTRY="registry.hub.docker.com"
IMAGE="okojo-devcontainer"
res=$(docker ps -a --filter "name=$IMAGE" --format "{{.ID}} {{.State}}")


CID=$(echo $res | awk '{print $1}')
STATE=$(echo $res | awk '{print $2}')
echo $CID
echo $STATE

if [ -n "$CID" ] && [ $STATE = "exited" ]; then
  docker start $CID;
  docker exec -it $CID /bin/bash
elif [ -n "$CID" ] && [ $STATE = "running" ]; then
  docker exec -it $CID /bin/bash
elif [ "$CID" = "" ]; then
  docker run -it -d --name okojo-devcontainer --dns=8.8.8.8 --mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock --mount type=volume,src=vscode-extensions,dst=${HOME}/.vscode-server/extensions -v ${HOME}/work:${HOME}/work okojo-devcontainer
  docker exec -it $IMAGE /bin/bash
fi
