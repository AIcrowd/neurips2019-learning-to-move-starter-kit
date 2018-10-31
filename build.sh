#!/bin/bash

ARGS=$1


crowdai-repo2docker --no-run \
  --user-id 1001 \
  --user-name crowdai \
  --image-name ${IMAGE_NAME} \
  --debug .
