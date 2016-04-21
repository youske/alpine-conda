# Alpine Linux glibc with conda
# frolvlad/alpine-glibc based

FROM frolvlad/alpine-glibc
MAINTAINER youske miyakoshi <youske@gmail.com>

LABEL com.geeplus.description="alpine miniconda image" \
      com.geeplus.role="baseimage"

ENV ENTRYKIT_VERSION=0.4.0
ENV ENTRYKIT_FILE=entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz
ENV ENTRYKIT_DOWNLOAD=https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/${ENTRYKIT_FILE}

ENV GOSU_VERSION=1.7
ENV GOSU_DOWNLOAD=https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64

ENV CONDA_BASE=/conda
ENV MINICONDA=Miniconda-latest-Linux-x86_64.sh
ENV CONDA_URL=https://repo.continuum.io/miniconda/${MINICONDA}
ENV CONDA_PACKAGE="virtualenv"

ENV PACKAGE='bash ca-certificates libstdc++ openssh-client' \
    DOWNLOAD_PACKAGE='wget git build-base linux-headers' \
    LANG=C.UTF-8 \
    PATH=${CONDA_BASE}/bin:$PATH \
    WORK_DIR=/home/admin

# apk install
RUN apk update --no-cache && apk add --no-cache ${PACKAGE} && apk add --no-cache ${DOWNLOAD_PACKAGE} -t buildpack

# entrykit install
RUN wget -q --no-check-certificate ${ENTRYKIT_DOWNLOAD} -O- | tar zx && \
    chmod +x /entrykit && mv /entrykit /usr/bin && /usr/bin/entrykit --symlink

# gosu
RUN wget -q --no-check-certificate ${GOSU_DOWNLOAD} -O /usr/bin/gosu && chmod +x /usr/bin/gosu

# conda install
RUN wget -q --no-check-certificate ${CONDA_URL} && \
    bash /${MINICONDA} -b -p ${CONDA_BASE} && \
    ln -s ${CONDA_BASE}/bin/* /usr/local/bin/ && \
    rm -rf /root/.[acpw]* /${MINICONDA} ${CONDA_BASE}/pkgs/* && \
    conda update -q -y conda && conda install -y ${CONDA_PACKAGE} && conda clean -itpsly

RUN apk del buildpack --no-cache && rm -rf /tmp/* /var/cache/apk/*

# add admin user
RUN adduser -D -h /home/admin -s /bin/bash admin admin

WORKDIR ${WORK_DIR}
CMD ["/bin/bash"]
