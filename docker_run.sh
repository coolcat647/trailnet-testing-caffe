#!/usr/bin/env sh

# Setup the style of color
RED='\033[0;31m'
NC='\033[0m'

# Find current directory and transfer it to container directory for Docker
jupyter_port="8889"
current_dir="$(pwd)"
host_dir="${HOME}/"
container_dir="/root/"
goal_dir=${current_dir//$host_dir/$container_dir}
echo "goal_dir: \"${goal_dir}\""

# export env
export JUPYTER_PORT="${jupyter_port}"

# Check the command 'nvidia-docker' is existing or not
ret_code="$(command -v nvidia-docker)"
if [ -z "$ret_code" ]
then
    printf "${RED}\"nvidia-docker\" is not found, so substitute docker. $NC\n"
    docker run -it --rm -v ${current_dir}:${goal_dir} \
                        -p "${jupyter_port}":"${jupyter_port}" \
                        -w "${goal_dir}" \
                        -e JUPYTER_PORT="${jupyter_port}" \
                        --name trailnet-test \
                        argnctu/ros-caffe
else
    printf "Run \"nvidia-docker\"\n"
    nvidia-docker run -it --rm -v ${current_dir}:${goal_dir} \
                               -p "${jupyter_port}":"${jupyter_port}" \
                               -w ${goal_dir} \
                               -e JUPYTER_PORT="${jupyter_port}" \
                               --name trailnet-test \
                               argnctu/ros-caffe 
fi
