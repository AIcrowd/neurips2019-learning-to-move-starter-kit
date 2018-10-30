#!/bin/bash

ARGS=$1

source environ.sh

crowdai-repo2docker --no-run \
  --user-id 1001 \
  --user-name crowdai \
  --image-name ${IMAGE_NAME} \
  --debug .



if [ "$ARGS" = "push" ]; then
  docker push ${IMAGE_NAME}
fi
