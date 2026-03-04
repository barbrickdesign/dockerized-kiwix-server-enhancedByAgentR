# Dockerized Kiwix Server

> Run your own offline Wikipedia (or any Kiwix ZIM content) with a single Docker command!

[![Build Docker Image](https://github.com/barbrickdesign/dockerized-kiwix-server-enhancedByAgentR/actions/workflows/docker-build.yml/badge.svg)](https://github.com/barbrickdesign/dockerized-kiwix-server-enhancedByAgentR/actions/workflows/docker-build.yml)

## What is Kiwix?

[Kiwix](https://www.kiwix.org/) lets you read Wikipedia, Project Gutenberg, Stack Overflow, and thousands of other resources **offline**. Content is distributed as `.zim` files.

## Quick Start

### 1. Download a ZIM file

Grab any `.zim` file from the [Kiwix Library](https://library.kiwix.org/).

### 2. Run the container

**Single ZIM file:**

```bash
docker run -d \
  -v /path/to/your/zim/files:/kiwix-data:ro \
  -p 8080:8080 \
  ghcr.io/barbrickdesign/dockerized-kiwix-server-enhancedbyagentr:main \
  wikipedia_en_all_mini.zim
```

**Multiple ZIM files via a library XML:**

```bash
# First, generate the library.xml
docker run --rm \
  -v /path/to/your/zim/files:/kiwix-data \
  ghcr.io/barbrickdesign/dockerized-kiwix-server-enhancedbyagentr:main \
  kiwix-manage /kiwix-data/library.xml add /kiwix-data/wikipedia.zim

# Then serve everything in the library
docker run -d \
  -v /path/to/your/zim/files:/kiwix-data:ro \
  -p 8080:8080 \
  ghcr.io/barbrickdesign/dockerized-kiwix-server-enhancedbyagentr:main \
  --library /kiwix-data/library.xml
```

Open your browser at **http://localhost:8080** 🎉

---

## Docker Compose

Copy `docker-compose.yml`, place your ZIM files in `./kiwix-data/`, then:

```bash
docker compose up -d
```

Edit the `command:` line in `docker-compose.yml` to change which ZIM file is served.

---

## Building locally

```bash
docker build -t kiwix-server .
docker run -d -v /path/to/zims:/kiwix-data:ro -p 8080:8080 kiwix-server wikipedia_en_all_mini.zim
```

---

## What's new in this fork

| Feature | Original | This fork |
|---|---|---|
| Base image | `alpine:latest` (unpinned) | `alpine:3.21` (pinned) |
| Kiwix version | 0.10 (2015) | Latest via Alpine packages |
| Architecture | Broken URL (`x86_84` typo) | Correct (`x86_64`), multi-arch builds |
| Security | Root user | Non-root user (`kiwix`, UID 1000) |
| Health check | ✗ | ✓ Docker HEALTHCHECK |
| Docker Compose | ✗ | ✓ `docker-compose.yml` included |
| CI/CD | ✗ | ✓ GitHub Actions builds & pushes to GHCR |
| Multi-arch | ✗ | ✓ `linux/amd64` + `linux/arm64` |

---

## Screenshots

![wikipedia1.png](snaps/wikipedia1.png)
![wikipedia2.png](snaps/wikipedia2.png)
