FROM ubuntu:22.04

ARG MAVEN_VERSION=3.9.11
ARG USER_HOME_DIR="/root"
ARG SHA=bcfe4fe305c962ace56ac7b5fc7a08b87d5abd8b7e89027ab251069faebee516b0ded8961445d6d91ec1985dfe30f8153268843c89aa392733d1a3ec956c9978
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

CMD mvn clean verify -B -Dbytecode.version=17 && \
    cp jacoco/target/jacoco-*.zip /artifacts 

