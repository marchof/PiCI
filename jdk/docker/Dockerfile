FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    fontconfig \
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

RUN ln -s /jdk/bin/java /usr/bin/java

ENV JAVA_HOME jdk
ENV PATH /jdk/bin:$PATH

VOLUME /workspace /artifacts /jdk

WORKDIR /workspace

CMD rm -rf build && \ 
    bash configure --disable-warnings-as-errors --with-native-debug-symbols=none && \
    make images && \
    cp -Lr build/linux-arm-server-release/images/jdk /artifacts
