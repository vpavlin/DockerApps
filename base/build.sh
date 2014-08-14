#!/bin/bash

set -x

if [ "${1}" == "base" ] || [ "${1}" == "" ]; then
    TAG=vpavlin/gui-base
    NAME=base
    BUILD_PATH="."
else
    TAG=vpavlin/${1}-gui-cont
    NAME=${1}
    BUILD_PATH="../dockerfiles/${1}/"
fi


HOME_DIR="${HOME}/.dockerapps/${NAME}"



if [ "${NAME}" == "base" ]; then 
    ssh-keygen -f ssh/cont_id_rsa -q -N ""
else
    if ! [ -d ${HOME_DIR} ]; then
        mkdir -p ${HOME_DIR}/.ssh/
    fi
    mkdir $BUILD_PATH/ssh
    cp ssh/cont_id_rsa.pub $BUILD_PATH/ssh/authorized_keys
    cp ssh/cont_id_rsa ${HOME_DIR}/.ssh/cont_id_rsa 

fi 

docker build -t ${TAG} ${BUILD_PATH}

echo "Image name: $NAME"
