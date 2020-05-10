#!/bin/bash

cd "$(dirname "$0")"
NAME="$(basename "$(pwd)")"
CONTAINER="$NAME"
IMAGE="$NAME"

_build() {
	set -x
	/usr/bin/docker build \
		--tag $IMAGE:latest\
	.
}

_stop() {
	set -x
	/usr/bin/docker stop $CONTAINER
	/usr/bin/docker rm $CONTAINER
}

_start() {
	set -x
	/usr/bin/docker run \
		--detach \
		--stop-timeout 1 \
		--restart unless-stopped \
		-p 127.0.0.1:10050:10050/tcp \
		--name $CONTAINER \
	$IMAGE
}

_logs() {
	set -x
	/usr/bin/docker logs \
		--follow \
		--timestamps \
		--details \
	$CONTAINER
}

_usage() {
		echo Usage:
		echo "$0 stop|restart|update|logs"
}

case $1 in
	start|restart) echo Restarting
		_stop
		_start
		;;
	stop) echo Stopping
		_stop
		;;
	build|rebuild) echo Rebuilding
		_build
		;;
	update|upgrade|up) echo Updating
		_stop
		_build
		_start
		;;
	log|logs) echo Showing Logs
		_logs
		;;
	*)
		_usage
		;;
esac

exit 0
