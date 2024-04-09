#!/bin/bash

# Define the Docker image name and container name
image_name="lsrainforestcafe-container"
container_name="lsrainforestcafe-container"

# Define the sleep time in seconds
sleep_time=5

# Define the total sleep time
total_sleep_time=120

# Function to display a progress bar
progress_bar() {
    local duration=$1
    local progress=0
    local progress_char="#"

    while [ $progress -lt $duration ]; do
        echo -n "$progress_char"
        ((progress++))
        sleep 1
    done
}

echo "Stopping and removing any existing containers with the name $container_name..."
# Stop and remove any existing containers with the same name
docker stop $container_name >/dev/null 2>&1 || true
docker rm $container_name >/dev/null 2>&1 || true

echo "Waiting for the container to be completely stopped and removed..."
# Wait for the container to be completely stopped and removed
progress_bar $total_sleep_time

echo "Starting a new container with the name $container_name..."
# Run the Docker container with restart policy
docker run -d --name $container_name $image_name

echo "Container $container_name started successfully."
