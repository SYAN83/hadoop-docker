# Linux base image
#
# VERSION 0.1

FROM ubuntu:18.10

LABEL maintainer="yanshu.usc@gmail.com"

# upgrade system & install the requisite software
RUN	apt update \
  && apt -y upgrade \
  && apt install -y --no-install-recommends \
     ssh \
     pdsh \
     rsync \
     git \
     sudo \
     vim \
     wget \
     figlet
RUN apt install -y --no-install-recommends openjdk-8-jdk
RUN rm -rf /var/lib/apt/lists/*

# set the environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV PATH=$PATH:$JAVA_HOME/bin

# create ubuntu user
RUN adduser --disabled-password --gecos '' ubuntu
RUN adduser ubuntu sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ubuntu
WORKDIR /home/ubuntu
