# Welcome to the official Hue (http://gethue.com) developer Dockerfile
FROM ubuntu:trusty
MAINTAINER The Hue Team "https://github.com/cloudera/hue"

RUN apt-get update -y

RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update -y

RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java8-installer

RUN apt-get update -y
RUN apt-get install --fix-missing -q -y \
  git \
  ant \
  gcc \
  g++ \
  libkrb5-dev \
  libmysqlclient-dev \
  libssl-dev \
  libsasl2-dev \
  libsasl2-modules-gssapi-mit \
  libsqlite3-dev \
  libtidy-0.99-0 \
  libxml2-dev \
  libxslt-dev \
  libffi-dev \
  make \
  maven \
  libldap2-dev \
  python-dev \
  python-setuptools \
  libgmp3-dev \
  libz-dev

RUN mkdir /hue
WORKDIR hue
COPY . /hue
RUN make apps
RUN apt-get install -y tmux
EXPOSE 9999
VOLUME /hue/desktop/
COPY desktop/conf/pseudo-distributed.ini.tmpl /hue/desktop/conf/pseudo-distributed.ini
