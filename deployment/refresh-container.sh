#!/bin/bash

CONTAINER_NAME=about-me-site

IMAGE_NAME=kiranrdm/about-me-site:latest

if [ $(sudo docker ps -q -f name=$CONTAINER_NAME) ]; then
    echo "Stopping container $CONTAINER_NAME..."
    sudo docker stop $CONTAINER_NAME
fi

if [ $(sudo docker ps -aq -f name=$CONTAINER_NAME) ]; then
    echo "Removing container $CONTAINER_NAME..."
    sudo docker rm $CONTAINER_NAME
fi

echo "Pulling latest Docker image $IMAGE_NAME..."
sudo docker pull $IMAGE_NAME

echo "Starting new container $CONTAINER_NAME..."
sudo docker run -d --name $CONTAINER_NAME --restart unless-stopped -p 8080:80 $IMAGE_NAME
