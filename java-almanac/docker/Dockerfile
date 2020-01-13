FROM ubuntu:19.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    awscli


ARG SHA=cc9fa8f56ccbd9d7aaa5954de4a858643503da26a61d35c0fd8acd13dcda7a74
ARG URL=https://github.com/gohugoio/hugo/releases/download/v0.62.2/hugo_0.62.2_Linux-ARM.deb

RUN curl -fsSL -o /tmp/hugo.deb ${URL} && \
    echo "${SHA} /tmp/hugo.deb" | sha256sum -c - && \
    dpkg -i /tmp/hugo.deb


VOLUME /site /artifacts

WORKDIR /site

CMD hugo && \
    hugo deploy --maxDeletes 100 && \
    aws cloudfront create-invalidation --distribution-id ECI1PGYSTNAWG --paths "/*"
