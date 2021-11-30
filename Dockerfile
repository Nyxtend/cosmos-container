FROM ubuntu:latest

# Rough instructions derived from
# https://hub.cosmos.network/main/gaia-tutorials/installation.html

# Install dependencies
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get upgrade -qqy && \
  DEBIAN_FRONTEND=noninteractive apt-get install -qqy \
    build-essential \
    ca-certificates \
    curl \
    gcc \
    git \
    gpg \
    jq \
    make \
    pkg-config \
    rename \
    sudo \
    tar \
    wget

# Cosmos requires go version 1.16+
RUN wget -c https://golang.org/dl/go1.16.4.linux-amd64.tar.gz -O - | tar -xz -C /usr/local

# Add go to the path
ENV PATH="${PATH}:/usr/local/go/bin"

# Setup working environment
RUN mkdir -p /work
WORKDIR /work

# Clone the repo and select the most recent release
RUN clone -b v6.0.0 https://github.com/cosmos/gaia
WORKDIR /work/gaia
RUN make install

# Check version
RUN gaiad version --long

# Add startup script
WORKDIR /work
ADD docker-init.sh .
RUN chmod +x docker-init.sh

# Expose the lotus data and log folders as volumes, these should be persisted
CMD ["/work/docker-init.sh"]
