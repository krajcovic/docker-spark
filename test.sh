#!/bin/bash

set -e

echo "=> Building spark  image"
docker build -t krajcovic/spark .

container_name=sparktest

# Echo Remove container if exist.
container_id=$(docker ps -a -q -f name=${container_name})
if [ $container_name ]; then
	echo 'Stopping container '${container_id}
	docker stop ${container_name}
	echo 'Removing container '${container_id}
	docker rm $container_name
fi

echo "=> Testing if spark is running"
docker run -it --name sparktest -e JAVA_HOME=/usr/java/default --entrypoint="/bin/bash" krajcovic/spark
# docker run -it --name sparktest krajcovic/spark