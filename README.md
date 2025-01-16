# tauri-arm64# Cross-Platform Toolchain for Tauri Projects (ARM Architecture)

## Overview

This repository provides a Docker-based toolchain to compile Tauri projects for ARM architecture. It simplifies the process of building cross-platform Tauri apps by leveraging Docker to create consistent and portable build environments.

## Prerequisites

Before using this toolchain, ensure Docker is installed and the Docker daemon is running on your system. Refer to the [Docker documentation](https://docs.docker.com/get-started/) for setup instructions if needed.

## Getting Started

Follow these steps to download and use the toolchain:

### 1. Clone the Repository

Use `git` to clone this repository to your local machine:

```bash
git clone https://github.com/your-username/tauri-arm-toolchain.git
cd tauri-arm-toolchain
```

### 2. Run the Build Script

Run the provided script to compile your Tauri project for ARM architecture. Replace the placeholders with the appropriate paths and architecture:

```bash
./build.sh /path/to/project /path/to/output ARCHITECTURE
```

- `/path/to/project`: The full path to your Tauri project directory.
- `/path/to/output`: The directory where the build artifacts will be stored.
- `ARCHITECTURE`: The target architecture (e.g., `arm64`).

For example:

```bash
./build.sh ~/projects/my-tauri-app ~/build-output arm64
```

### 3. Retrieve the Build Output

The compiled binaries will be available in the specified output directory (`/path/to/output`).

## License

This project is licensed under the MIT License. See the LICENSE file for details.

