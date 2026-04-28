FROM ubuntu:26.04 AS base

ENV DEBIAN_FRONTEND=noninteractive

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
    ca-certificates \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /src

# Note: Using the 'develop' branch as requested by your supervisor. 
# For long-term reproducibility later, you might want to switch this to a specific release tag!
RUN git clone --branch=develop --single-branch https://gitlab.com/QEF/q-e.git

WORKDIR /src/q-e/build

RUN ../configure && \
    make -j"$(nproc)" all

ENV PATH="/src/q-e/bin:${PATH}"

WORKDIR /root/shared

CMD ["/bin/bash"]
