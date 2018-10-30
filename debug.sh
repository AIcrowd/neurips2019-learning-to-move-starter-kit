#!/bin/bash

ARG=$1

source environ.sh
if [ "$ARG" = "build_push" ]; then
  ./build.sh
  docker push ${IMAGE_NAME}
fi

REDIS_HOST="localhost"
OS=$(uname -s)
if [ "$OS" = "Darwin" ]; then
	REDIS_HOST="docker.for.mac.host.internal"
fi

docker run -it \
  --net=host \
  -e CROWDAI_REDIS_HOST=$REDIS_HOST \
  -e CROWDAI_IS_GRADING=True \
  -e CROWDAI_DEBUG_MODE=True \
  -v `pwd`:/www \
  $IMAGE_NAME \
  /www/run.sh
