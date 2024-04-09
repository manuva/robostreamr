# Use a base image with ffmpeg and Bash installed
FROM alpine:latest

# Set the working directory in the container
WORKDIR /app

# Copy the entire youtube-live-radio directory into the container's /app directory
COPY . .

# Install Bash
RUN apk add --no-cache bash

# Install any additional dependencies if needed
RUN apk add --no-cache ffmpeg

# Make the script executable
RUN chmod +x /app/stream.sh

# Define the command to run your script
CMD ["/bin/bash", "/app/stream.sh"]
