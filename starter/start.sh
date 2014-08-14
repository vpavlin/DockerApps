#!/bin/bash

set -x

NAME="${1}"
DOCKER_USER="${1}"


[ "${2}" != "" ] && DOCKER_USER="${2}"

# docker image to use
DOCKER_IMAGE_NAME="vpavlin/${NAME}-gui-cont"

# local name for the container
DOCKER_CONTAINER_NAME="${NAME}-gui-cont"

RUN="${NAME}"
HOME_DIR="${HOME}/.dockerapps/${NAME}"

SSH_KEY_FILE_PRIVATE=${HOME_DIR}/.ssh/cont_id_rsa

if ! [ -d ${HOME_DIR} ]; then
    mkdir -p ${HOME_DIR}
fi

# check if container already present
TMP=$(docker ps -a | grep ${DOCKER_CONTAINER_NAME})
CONTAINER_FOUND=$?

TMP=$(docker ps | grep ${DOCKER_CONTAINER_NAME})
CONTAINER_RUNNING=$?

if [ $CONTAINER_FOUND -eq 0 ]; then

	echo -n "container '${DOCKER_CONTAINER_NAME}' found, "

	if [ $CONTAINER_RUNNING -eq 0 ]; then
		echo "already running"
	else
		echo -n "not running, starting..."
		TMP=$(docker start ${DOCKER_CONTAINER_NAME})
		echo "done"
	fi

else
	echo -n "container '${DOCKER_CONTAINER_NAME}' not found, creating..."
	TMP=$(docker run -d -P -v /home/vpavlin/Stažené:/home/vlc/Stažené:rw -v ${HOME_DIR}:/${DOCKER_USER}:rw --name ${DOCKER_CONTAINER_NAME} ${DOCKER_IMAGE_NAME})
	echo "done"
fi

#wait for container to come up
sleep 2

# find ssh port
SSH_URL=$(docker port ${DOCKER_CONTAINER_NAME} 22)
SSH_URL_REGEX="(.*):(.*)"

SSH_INTERFACE=$(echo $SSH_URL | awk -F  ":" '/1/ {print $1}')
SSH_PORT=$(echo $SSH_URL | awk -F  ":" '/1/ {print $2}')

echo "ssh running at ${SSH_INTERFACE}:${SSH_PORT}"

ssh -i ${SSH_KEY_FILE_PRIVATE} -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -Y -X ${DOCKER_USER}@${SSH_INTERFACE} -p ${SSH_PORT} ${RUN}
