#!/bin/bash

# We need to make sure all the tags match also the online/dockerfile tags
LONG_PREFIX="abr-ijs/panda_dockers"
SHORT_PREFIX="ijs"

build_and_tag () {
  #docker build . -f $IMAGE.Dockerfile -t $LONG_PREFIX:$IMAGE
  docker build $IMAGE -t $LONG_PREFIX:$IMAGE
  docker tag $LONG_PREFIX:$IMAGE $SHORT_PREFIX:$IMAGE
}

IMAGES=("kinetic-devel" "kinetic-gazebo" "panda-simulator" "gzweb" "panda-gzweb")
IMAGES+=("sim_controllers_interface") # comment out if you don't have access

for IMAGE in ${IMAGES[@]}; do build_and_tag; done
