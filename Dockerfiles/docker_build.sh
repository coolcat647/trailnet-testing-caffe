#!/usr/bin/env sh
COLOR_YELLOW='\033[0;33m'
COLOR_NC='\033[0m'

if [ $# -gt 0 ]; then
    if [ "$1" == "cuda8" ]; then
        docker build -t argnctu/ros-caffe -f Dockerfile-cuda8 .
    elif [ "$1" == "cuda10" ]; then
        docker build -t argnctu/ros-caffe -f Dockerfile-cuda10 .
    else
        echo -e "Please specify which cuda version your GPU support."
        echo -e "${COLOR_YELLOW}Usage: source docker_build.sh [cuda8 | cuda10]${COLOR_NC}"
    fi
else
    echo -e "${COLOR_YELLOW}Usage: source docker_build.sh [cuda8 | cuda10]${COLOR_NC}"
fi
