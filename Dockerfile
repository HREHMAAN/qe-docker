FROM ubuntu:26.04 AS base

ENV DEBIAN_FRONTEND=noninteractive

# Allow OpenMPI to run inside Docker as root
ENV OMPI_ALLOW_RUN_AS_ROOT=1
ENV OMPI_ALLOW_RUN_AS_ROOT_CONFIRM=1

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
    openmpi-bin \
    libopenmpi-dev \
    libscalapack-openmpi-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src

# For long-term reproducibility, consider switching to a fixed release tag.
RUN git clone --depth=1 --branch=develop --single-branch https://gitlab.com/QEF/q-e.git

WORKDIR /src/q-e/build

RUN ../configure MPIF90=mpif90 CC=mpicc F90=mpif90 && \
    make -j"$(nproc)" all

ENV PATH="/src/q-e/build/bin:${PATH}"

WORKDIR /root/shared

CMD ["/bin/bash"]
