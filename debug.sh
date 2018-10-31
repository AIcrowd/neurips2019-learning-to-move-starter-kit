#!/bin/bash


HOST="localhost"
OS=$(uname -s)
if [ "$OS" = "Darwin" ]; then
	HOST="docker.for.mac.host.internal"
fi

docker run -it \
  --net=host \
  -e CROWDAI_REDIS_HOST=$HOST \
  -e CROWDAI_IS_GRADING=True \
  -e CROWDAI_DEBUG_MODE=True \
  -v `pwd`:/www \
  $IMAGE_NAME \
  /www/run.sh
