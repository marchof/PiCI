FROM ubuntu:22.04

ARG MAVEN_VERSION=3.9.9
ARG USER_HOME_DIR="/root"
ARG SHA=a555254d6b53d267965a3404ecb14e53c3827c09c3b94b5678835887ab404556bfaf78dcfe03ba76fa2508649dca8531c74bca4d5846513522404d48e8c4ac8b
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

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

CMD mvn clean verify -B -Dbytecode.version=18 && \
    cp jacoco/target/jacoco-*.zip /artifacts 

