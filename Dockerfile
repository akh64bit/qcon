FROM ubuntu:16.04

MAINTAINER akhikuma@adobe.com

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        vim && \
    rm -rf /var/lib/apt/lists/*

ADD https://repo.continuum.io/miniconda/Miniconda3-4.5.4-Linux-x86_64.sh .
RUN chmod a+rwx Miniconda3-4.5.4-Linux-x86_64.sh && \
    bash Miniconda3-4.5.4-Linux-x86_64.sh -b && \
    rm Miniconda3-4.5.4-Linux-x86_64.sh
ENV PATH="/root/miniconda3/bin:${PATH}"
RUN pip install --force-reinstall pip==9.0.3 && \
    conda create -n 36 python=3.6 anaconda -y && \
    /bin/bash -c "source activate 36" && \
    mkdir analysis
ADD . /analysis
WORKDIR /analysis   
RUN pip install -r requirements.txt

EXPOSE 8888

CMD jupyter notebook --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token=''
