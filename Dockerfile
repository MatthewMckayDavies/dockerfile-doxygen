# Based on Dockerfile from https://github.com/doxygen/doxygen/
FROM ubuntu:22.04 AS builder

RUN apt-get update && apt-get install -y \
    g++ \
    python3 \
    cmake \
    flex \
    bison \
    wget \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
RUN wget https://www.doxygen.nl/files/doxygen-1.10.0.src.tar.gz
RUN wget https://github.com/plantuml/plantuml/releases/download/v1.2024.4/plantuml-lgpl-1.2024.4.jar

RUN gunzip doxygen-1.10.0.src.tar.gz
RUN tar xf doxygen-1.10.0.src.tar

RUN cd doxygen-1.10.0 \
    && mkdir build \
    && cd build \
    && cmake -G "Unix Makefiles" .. \
    && make \
    && make install

FROM ubuntu:22.04
RUN apt-get update && apt-get install --no-install-recommends -y \
    graphviz openjdk-17-jre \
    && rm -rf /var/lib/apt/lists/*
COPY --from=builder /tmp/doxygen-1.10.0/build/bin/doxygen /usr/local/bin/
COPY --from=builder /tmp/plantuml-lgpl-1.2024.4.jar /usr/local/bin/plantuml.jar

# User management
RUN groupadd -g 1000 cmonkey && useradd -u 1000 -g 1000 -ms /bin/bash cmonkey
RUN PATH=${PATH}:/usr/local/bin 

USER cmonkey

WORKDIR /home/workspace
