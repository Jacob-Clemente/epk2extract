# Build Stage
FROM --platform=linux/amd64 ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cmake

## Install build dependencies.

## Add source code to the build stage.
ADD . /epk2extract
WORKDIR /epk2extract/build

## TODO: ADD YOUR BUILD INSTRUCTIONS HERE.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential 
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y libssl-dev
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y liblzo2-dev libc6-dev zlib1g-dev && cmake .. && make

#Package Stage
FROM --platform=linux/amd64 ubuntu:20.04

## TODO: Change <Path in Builder Stage>
COPY --from=builder /epk2extract/build/src/tools/idb_extract /
