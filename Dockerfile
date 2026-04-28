FROM ubuntu:26.04 AS base

# Prevent interactive prompts during apt installations
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies and clean up apt cache to save space
# hadolint ignore=DL3008
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    curl \
    wget \
    unzip \
    pkg-config \
    gfortran \
    liblapack-dev \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /src

# Clone the Quantum ESPRESSO repository
RUN git clone --branch=develop --single-branch https://gitlab.com/QEF/q-e.git

WORKDIR /src/q-e

# Configure and build
RUN ./configure && \
    make -j"$(nproc)" all

# Add the Q-E binaries to the system PATH
ENV PATH="/src/q-e/bin:${PATH}"

# Default command when the container starts
CMD ["/bin/bash"]
