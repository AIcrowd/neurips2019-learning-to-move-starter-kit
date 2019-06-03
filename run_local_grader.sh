#!/bin/bash 

HOST="localhost"
OS=$(uname -s)
if [ "$OS" = "Darwin" ]; then
	HOST="docker.for.mac.host.internal"
fi

docker run -it \
  --net=host \
  --name redis \
  -e ALLOW_EMPTY_PASSWORD=yes \
  aicrowd/neurips-learning-to-move-subcontractor \
  /home/aicrowd/run.sh
