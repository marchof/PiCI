FROM ubuntu:19.04


RUN apt-get update && apt-get install -y \
    curl \
    python3 \
    python3-pip

RUN pip3 install awscli --upgrade --user


ARG SHA=8d59e4469f2a579935dc13e2a54ef4cc313f2f6a2f88d424cc0c803df65440dd
ARG URL=https://github.com/gohugoio/hugo/releases/download/v0.59.1/hugo_0.59.1_Linux-ARM.deb

RUN curl -fsSL -o /tmp/hugo.deb ${URL} && \
    echo "${SHA} /tmp/hugo.deb" | sha256sum -c - && \
    dpkg -i /tmp/hugo.deb


VOLUME /site /artifacts

WORKDIR /site

CMD hugo && \
    hugo deploy --maxDeletes 0
