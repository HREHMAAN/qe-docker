FROM ubuntu:26.04 AS base


RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    curl \
    wget \
    unzip \
    pkg-config \
    gfortran \
    liblapack-dev
WORKDIR /src
RUN git clone --branch=develop --single-branch https://gitlab.com/QEF/q-e.git
WORKDIR /src/q-e
RUN ./configure
RUN make -j 8 all


