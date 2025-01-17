#!/bin/bash

set -e

# Default values
PROJECT_DIR=$(pwd)
OUTPUT_DIR=$(pwd)
PROJECT_NAME=$(basename "$PROJECT_DIR")
DOCKERFILE_DIR=$(pwd)

# Parse arguments
while getopts "p:o:" opt; do
  case $opt in
    p) PROJECT_DIR=$(realpath "$OPTARG") ;;
    o) OUTPUT_DIR=$(realpath "$OPTARG") ;;
    *) echo "Usage: $0 [-p project_dir] [-o output_dir]"; exit 1 ;;
  esac
done

# Validate project directory
if [ ! -d "$PROJECT_DIR" ]; then
  echo "Error: Directory '$PROJECT_DIR' does not exist."
  exit 1
fi

# Check if package.json exists in the project directory
if [ ! -f "$PROJECT_DIR/package.json" ]; then
  echo "Error: No package.json found in '$PROJECT_DIR'."
  exit 1
fi

# Check if Dockerfile exists in the current script directory
if [ ! -f "$DOCKERFILE_DIR/Dockerfile" ]; then
  echo "Error: Dockerfile not found in '$DOCKERFILE_DIR'."
  exit 1
fi

# Build Docker image
IMAGE_NAME="${PROJECT_NAME}-docker:bookworm"
echo "Building Docker image: $IMAGE_NAME"
docker build --file "$DOCKERFILE_DIR/Dockerfile" --build-arg PROJECT_NAME="$PROJECT_NAME" -t "$IMAGE_NAME" "$PROJECT_DIR"

# Create a temporary container to extract files
CONTAINER_ID=$(docker create "$IMAGE_NAME")

# Copy build artifacts from the container to the output directory
echo "Extracting build artifacts to $OUTPUT_DIR..."
docker cp "$CONTAINER_ID:/bundle" "$OUTPUT_DIR"

# Clean up the temporary container
docker rm "$CONTAINER_ID"

echo "Build artifacts are available in the output directory: $OUTPUT_DIR"
