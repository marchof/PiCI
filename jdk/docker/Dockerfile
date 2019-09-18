FROM adoptopenjdk:12.0.2_10-jdk-hotspot
# FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
    autoconf \
    file \
    g++ \
    gcc \
    libcups2-dev \
    libfontconfig1-dev \
    libasound2-dev \
    libx11-dev \
    libxext-dev \
    libxrender-dev \
    libxrandr-dev \
    libxtst-dev \
    libxt-dev \
    make \
    unzip \
    zip

WORKDIR /workspace

CMD rm -rf build && \ 
    bash configure --disable-warnings-as-errors --with-native-debug-symbols=none  && \
    make images

