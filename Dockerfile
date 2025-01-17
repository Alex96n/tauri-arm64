# Stage 1: Base Image for Tools and Dependencies
FROM debian:bookworm AS base

# Set up environment variables
ENV HOME=/root \
    CARGO_REGISTRIES_CRATES_IO_PROTOCOL=sparse \
    PATH="/root/.cargo/bin:${PATH}"

# Install system dependencies
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        curl \
        libwebkit2gtk-4.1-dev \
        build-essential \
        libssl-dev \
        libgtk-3-dev \
        libayatana-appindicator3-dev \
        librsvg2-dev \
        patchelf \
        libfuse2 \
        file \
        xdg-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Rust and Cargo
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends ca-certificates && \
    curl https://sh.rustup.rs -sSf | sh -s -- -y && \
    . "$HOME/.cargo/env" && \
    cargo --version

# Install Node.js LTS
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash && \
    apt-get install -y nodejs && \
    node --version && npm --version

# Stage 2: Prepare for Dependency Installation
FROM base AS dependencies

# Set the working directory inside the container
WORKDIR /app

# Copy the entire project directory
COPY . .

# Install frontend dependencies
RUN npm install

# Stage 3: Build the Tauri App
FROM dependencies AS build

# Build the Tauri app
RUN NO_STRIP=true npm run tauri build -- --verbose 

# Stage 4: Package Artifacts for Output
FROM debian:bookworm AS output

# Set the working directory
WORKDIR /bundle

# Copy the built artifacts from the build stage
COPY --from=build /app/src-tauri/target/release/bundle /bundle

# Set the default command to list the build output
CMD ["ls", "-l"]
