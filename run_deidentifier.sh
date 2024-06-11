#!/bin/bash

# Parse input arguments
INPUT_FOLDER=$1
DEVICE=$2

# Build the Docker image
docker build -t deidentifier .

# Run the Docker container with the specified arguments
docker run \
  -v $(pwd):/usr/src/app/Stanford_Penn_MIDRC_Deidentifier \
  -v $INPUT_FOLDER:/data \
  deidentifier \
  /data/input.csv \
  /data/output.csv \
  /data/output_review.csv \
  $DEVICE

# Remove temporary files
rm deidentification_details_for_review.csv
rm reports.npy
rm reports_deidentified.npy
rm deidentification_details_for_review_reports.npy
rm deidentification_details_for_review_labeled_reports.npy
rm deidentification_details_for_review_phi_lengths.npy