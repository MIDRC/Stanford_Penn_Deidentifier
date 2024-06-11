#!/bin/bash

# Parse input arguments
INPUT_PATH=$1
OUTPUT_PATH=$2
DEVICE=$3

# Build the Docker image
docker build -t deidentifier .

# Run the Docker container with the specified arguments
docker run -v $(pwd):/usr/src/app/Stanford_Penn_Deidentifier deidentifier $INPUT_PATH $OUTPUT_PATH $DEVICE
