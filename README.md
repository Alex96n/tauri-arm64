# Tauri ARM-Compiler for Raspberry Pi

## Overview

A Docker-based toolchain to compile Tauri projects for Raspberry Pi. It contains a Docker image which simulates compilation on Raspberry Pi OS (bookworm) to AppImage, .deb, and .rpm. A script is included for easier compilation. 

## Prerequisites

Before using this toolchain, ensure Docker is installed and the Docker daemon is running on your system. Refer to the [Docker documentation](https://docs.docker.com/get-started/) for setup instructions if needed.

## Getting Started

Follow these steps to download and use the toolchain:

### 1. Clone the Repository

First, clone the repository and navigate into the directory:

```bash
git clone https://github.com/alex96n/tauri-arm64.git
cd tauri-arm64
```

### 2. Run the Build Script

You can run the toolchain from anywhere by specifying the project folder and optionally the output folder using the flags:

```bash
./tauri-build.sh -p /path/to/tauri-project -o /path/to/output-folder
```

- **`-p`**: Specifies the path to the Tauri project directory.
- **`-o`**: Specifies the output directory where the build artifacts will be saved.

The compiled binaries will be saved in the output folder you specified. 

## License

This project is licensed under the MIT License. See the LICENSE file for details.

