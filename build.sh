#!/bin/bash

ARGS=$1


aicrowd-repo2docker --no-run \
  --user-id 1001 \
  --user-name aicrowd \
  --image-name ${IMAGE_NAME} \
  --debug .
