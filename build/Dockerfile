# Alpine Linux glibc with conda
# frolvlad/alpine-glibc based

FROM frolvlad/alpine-glibc
MAINTAINER youske miyakoshi <youske@gmail.com>

ENV PACKAGE='bash wget libstdc++' \
    LANG=C.UTF-8 \
    GOSU=https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64 \
    CONDA_BASE=/conda \
    MINICONDA=Miniconda-latest-Linux-x86_64.sh \
    CONDA_URL=https://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh \
    CONDA_PACKAGE="virtualenv" \
    PATH=/conda/bin:$PATH \
    WORK_DIR=/home/admin

RUN adduser -D -h /home/admin -s /bin/bash admin admin && \
    apk add --no-cache ${PACKAGE}

RUN wget -q --no-check-certificate -O /usr/local/bin/gosu ${GOSU} && \
    chmod +x /usr/local/bin/gosu

RUN wget -q --no-check-certificate ${CONDA_URL} && \
    bash /${MINICONDA} -b -p ${CONDA_BASE} && \
    ln -s ${CONDA_BASE}/bin/* /usr/local/bin/ && \
    rm -rf /root/.[acpw]* /${MINICONDA} ${CONDA_BASE}/pkgs/* && \
    conda update -q -y conda && conda install ${CONDA_PACKAGE} && conda clean -itpsly

COPY entrypoint.sh /docker-entrypoint.sh

#ENTRYPOINT ["/docker-entrypoint.sh"]
WORKDIR ${WORK_DIR}
CMD ["bash"]
