FROM ubuntu:22.04

ARG MAVEN_VERSION=3.9.15
ARG USER_HOME_DIR="/root"
ARG SHA=33d81e0ec785f0207e3e5e3ffb61863e1dca5784c15ac3fb5ff105f69cffbea484eb8d473ea60467a63f7b0570eef8622f2fed8eee96acbe668aa313391cddb3
ARG BASE_URL=https://dlcdn.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries

RUN apt-get update && apt-get install -y curl git

RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  && echo "${SHA}  /tmp/apache-maven.tar.gz" | sha512sum -c - \
  && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
  && rm -f /tmp/apache-maven.tar.gz \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

RUN ln -s /jdk/bin/java /usr/bin/java

COPY settings.xml /usr/share/maven/conf

VOLUME /workspace /jdk /m2repo /artifacts

ENV MAVEN_HOME /usr/share/maven
ENV JAVA_HOME /jdk

WORKDIR /workspace

CMD mvn clean verify -B -Dbytecode.version=26 && \
    cp jacoco/target/jacoco-*.zip /artifacts 

