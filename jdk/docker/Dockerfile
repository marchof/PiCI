FROM ubuntu:18.04

ARG BINARY_URL=https://github.com/AdoptOpenJDK/openjdk16-binaries/releases/download/jdk-16%2B36/OpenJDK16-jdk_arm_linux_hotspot_16_36.tar.gz
ARG ESUM=f1d32ba01a40c98889f31368c0e987d6bbda65a7c50b8c088623b48e3a90104a

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

RUN curl -LfsSo /tmp/openjdk.tar.gz $BINARY_URL; \
    echo "$ESUM */tmp/openjdk.tar.gz" | sha256sum -c -; \
    mkdir -p /opt/java/openjdk; \
    cd /opt/java/openjdk; \
    tar -xf /tmp/openjdk.tar.gz --strip-components=1; \
    rm -rf /tmp/openjdk.tar.gz

ENV JAVA_HOME=/opt/java/openjdk \
    PATH="/opt/java/openjdk/bin:$PATH"

VOLUME /workspace /artifacts

WORKDIR /workspace

CMD rm -rf build && \ 
    bash configure --disable-warnings-as-errors --with-native-debug-symbols=none  && \
    make images && \
    cp -Lr build/linux-arm-server-release/images/jdk /artifacts

