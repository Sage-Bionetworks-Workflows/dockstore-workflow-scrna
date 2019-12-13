# Base Image
FROM ubuntu:latest

# Metadata
LABEL base_image="ubuntu:latest"
LABEL software="Cell Ranger"
LABEL software.version="3.0.2"
LABEL about.documentation="https://github.com/10XGenomics/cellranger"
LABEL about.summary="Docker image for the CellRanger software.  This image is not provided\
    or supported by 10X Genomics, and uses the unsupported source code on github"
LABEL about.license="SPDX:MIT"
LABEL about.tags="scRNA"

# install dependencies
RUN apt-get update \
 && apt-get install -y \
    clang-6.0 \
    curl \
    cython \
    git \
    golang-1.10-go \
    libz-dev \
    libbz2-dev \
    liblzma-dev \
    python-numpy \
    python-pip

# install python dependencies with pip
RUN pip install python-config docopts

# export path to golang
ENV PATH="/usr/lib/go-1.10/bin:$PATH"

# download and install rustup
RUN curl https://sh.rustup.rs -sSf \
    | sh -s -- -y --profile minimal \
    --default-toolchain nightly

# export cargo path    
ENV PATH="/root/.cargo/bin:$PATH"

# install correct version of rustup
RUN rustup install 1.28.0 && rustup default 1.28.0

# clone cellranger sourcecode repo, cd into this dir, and install cellranger
RUN git clone https://github.com/10XGenomics/cellranger \
  && cd cellranger && make 

# setup environment to run cellranger
ENV PATH /cellranger/bin/:/cellranger/lib/bin:/cellranger/tenkit/bin/:\
    /cellranger/tenkit/lib/bin:/martian/bin/:$PATH

ENV PYTHONPATH /cellranger/lib/python:/cellranger/tenkit/lib/python:\
    /martian/adapters/python:$PYTHONPATH

ENV MROPATH /cellranger/mro/:/cellranger/tenkit/mro/
