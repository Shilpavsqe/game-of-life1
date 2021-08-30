FROM ubuntu
MAINTAINER Shilpavsqe
RUN mkdir /usr/app
WORKDIR /usr/app
COPY cd /var/lib/jenkins/workspace/Test-pipeline/gameoflife-build/target/gameoflife-build-1.0-SNAPSHOT.jar /usr/app
