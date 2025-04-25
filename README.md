# 🛠️ Tauri ARM-Compiler for Raspberry Pi

> A Docker-based cross-compilation toolchain for building Tauri apps for Raspberry Pi OS (Bookworm).

![tauri arm compiler banner](https://github.com/user-attachments/assets/b15b56a3-ea6f-4132-afbe-7b2748317881)

---

## 🎞️ Overview

This toolchain allows you to **compile Tauri projects for Raspberry Pi** (ARM64 architecture) inside a Docker container.  
It simulates compilation on **Raspberry Pi OS (Bookworm)** and produces:

- ✅ `.AppImage`
- ✅ `.deb`
- ✅ `.rpm`

Includes a helper script for easy usage.

---

## ⚙️ Prerequisites

Before you begin, make sure:

- **Docker is installed**
- **Docker daemon is running**

Refer to the [official Docker documentation](https://docs.docker.com/get-started/) if needed.

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/alex96n/tauri-arm64.git
cd tauri-arm64
```

---

### 2. Run the Build Script

You can build from anywhere by specifying:

- the path to your **Tauri project**
- (optionally) the desired **output directory**

```bash
./tauri-build.sh -p /path/to/tauri-project -o /path/to/output-folder
```

---

### 📟 Script Arguments

| Flag     | Description                               |
|----------|-------------------------------------------|
| `-p`     | Path to the Tauri project (required)      |
| `-o`     | Output folder for build artifacts (optional) |

> If `-o` is not provided, the artifacts will be saved in the default output directory inside the container.

---

## 📁 Output

The following binaries will be saved in the output folder:

- `your-app.AppImage`
- `your-app.deb`
- `your-app.rpm`

---

## 📜 License

This project is licensed under the **MIT License**.  
See the [LICENSE](./LICENSE) file for more details.

