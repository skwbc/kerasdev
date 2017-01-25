FROM ubuntu:16.04
MAINTAINER Shota Kawabuchi <shota.kawabuchi+git@gmail.com>

RUN set -x && \
  apt-get update && \
  apt-get install -y \
    build-essential \
    git \
    wget \
    vim &&\
  apt-get clean && \
  wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh && \
  bash miniconda.sh -b -p /miniconda

ENV PATH /miniconda/bin:$PATH
RUN set -x && \
  conda update -q conda -y && \
  conda info -a && \
  conda install \
    numpy \
    scipy \
    matplotlib \
    pandas \
    pytest \
    h5py \
    Pillow \
    jupyter \
    seaborn -y
    
RUN set -x && \
  pip install \
    pytest-cov \
    python-coveralls \
    pytest-xdist \
    coverage==3.7.1 \
    pep8 \
    pytest-pep8 \
    git+git://github.com/Theano/Theano.git \
    https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.12.1-cp35-cp35m-linux_x86_64.whl

COPY jupyter_notebook_config.py /root/.jupyter/
COPY matplotlibrc /root/.config/matplotlib/

# TensorBoard
EXPOSE 6006

# Jupyter Notebook
EXPOSE 8888

RUN mkdir /workspace
VOLUME /workspace
VOLUME /mnt
WORKDIR /workspace
