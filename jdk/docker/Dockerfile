FROM adoptopenjdk/openjdk12

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

VOLUME /workspace /artifacts

WORKDIR /workspace

CMD rm -rf build && \ 
    bash configure --disable-warnings-as-errors --with-native-debug-symbols=none  && \
    make images && \
    cp -Lr build/linux-arm-server-release/images/jdk /artifacts

