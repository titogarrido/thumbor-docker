FROM ubuntu:14.04

MAINTAINER Tito Garrido <titogarrido@gmail.com>

RUN apt-get update

RUN apt-get install -y \
        vim \
        build-essential \
        python-dev \
        python-pip \
	python-numpy \
	python-opencv \
	webp \
	libpng-dev \
	libtiff-dev \
	libjasper-dev \
	libjpeg-dev \
	curl \
	python-pycurl \
	libcurl4-openssl-dev \
        libwebp-dev \
	libdc1394-22-dev libdc1394-22 libdc1394-utils

RUN pip install setuptools --no-use-wheel --upgrade

RUN pip install --upgrade thumbor

ADD thumbor.conf /etc/thumbor.conf

#RUN sed -i 's/ALLOW_UNSAFE_URL = True/ALLOW_UNSAFE_URL = False/g' /etc/thumbor.conf
#RUN echo SECRET_KEY=\"`date +%s | sha256sum | base64 | head -c 32`\" >> /etc/thumbor.conf

# Clean up any files used by apt-get
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 8880

CMD thumbor --port=8880 -c /etc/thumbor.conf
