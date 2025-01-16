#!/bin/bash

# Ensure the script exits on error
set -e

# Display usage instructions
function usage() {
    echo "Usage: $0 -p <project_path> -o <output_path> -a <architecture> -n <project_name>"
    echo "  -p  Path to the project directory"
    echo "  -o  Path to the output directory"
    echo "  -a  Target architecture (e.g., amd64, arm64)"
    echo "  -n  Project name (as used in the Dockerfile)"
    exit 1
}

# Parse command-line arguments
while getopts "p:o:a:n:" opt; do
    case $opt in
        p) PROJECT_DIR="$OPTARG" ;;
        o) OUTPUT_DIR="$OPTARG" ;;
        a) ARCH="$OPTARG" ;;
        n) PROJECT_NAME="$OPTARG" ;;
        *) usage ;;
    esac
done

# Validate arguments
if [ -z "$PROJECT_DIR" ] || [ -z "$OUTPUT_DIR" ] || [ -z "$ARCH" ] || [ -z "$PROJECT_NAME" ]; then
    usage
fi

# Validate project directory
if [ ! -d "$PROJECT_DIR" ]; then
    echo "Error: Project directory '$PROJECT_DIR' does not exist."
    exit 1
fi

# Ensure the output directory exists
mkdir -p "$OUTPUT_DIR"

# Define Docker image name
IMAGE_NAME="tauri-toolchain:$ARCH"

# Build the Docker image for the specified architecture
echo "Building Docker image for $ARCH..."
docker build --platform "linux/$ARCH" -t "$IMAGE_NAME" \
    --build-arg PROJECT_NAME="$PROJECT_NAME" \
    "$PROJECT_DIR"

# Create a temporary container to extract files
echo "Creating a temporary container..."
CONTAINER_ID=$(docker create --platform "linux/$ARCH" "$IMAGE_NAME")

# Copy build artifacts from the container to the output directory
echo "Extracting build artifacts..."
docker cp "$CONTAINER_ID:/bundle" "$OUTPUT_DIR"

# Clean up the temporary container
docker rm "$CONTAINER_ID" > /dev/null

echo "Build artifacts have been saved to: $OUTPUT_DIR"
