FROM ubuntu:22.04

ARG MAVEN_VERSION=3.9.16
ARG USER_HOME_DIR="/root"
ARG SHA=831a8591fe20c8243b1dbe7d71e3244f31d1665b0804b2e825e38cbbe5ce0cafb8338851f90780735568773e0a6cd07bbec107cda0b896b008b861075358b6f6
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

CMD mvn clean verify -B -Dbytecode.version=11 && \
    cp jacoco/target/jacoco-*.zip /artifacts 

