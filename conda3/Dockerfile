# Alpine Linux glibc with conda

FROM frolvlad/alpine-glibc
MAINTAINER youske miyakoshi <youske@gmail.com>

LABEL com.geeplus.description="alpine miniconda python3 image" \
      com.geeplus.role="baseimage"

# s6-overlay
ENV S6OVERLAY_VERSION="v1.11.0.1"
ENV S6OVERLAY_URL="https://github.com/just-containers/s6-overlay/releases/download/${S6OVERLAY_VERSION}/s6-overlay-amd64.tar.gz"
ADD ${S6OVERLAY_URL} /tmp/

ENV ENTRYKIT_VERSION=0.4.0
ENV ENTRYKIT_FILE=entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz
ENV ENTRYKIT_DOWNLOAD=https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/${ENTRYKIT_FILE}

ENV GOSU_VERSION=1.7
ENV GOSU_DOWNLOAD=https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64

ENV CONDA_BASE=/conda
ENV MINICONDA=Miniconda3-latest-Linux-x86_64.sh
ENV CONDA_URL=https://repo.continuum.io/miniconda/${MINICONDA}
ENV CONDA_PACKAGE="virtualenv"

ENV PACKAGE='bash ca-certificates libstdc++ sudo' \
    DOWNLOAD_PACKAGE='wget git build-base musl-dev linux-headers' \
    LANG=C.UTF-8 \
    PATH=${CONDA_BASE}/bin:$PATH \
    WORK_DIR=/home/admin

# apk install
RUN apk upgrade --no-cache && \
    apk update --no-cache && \
    apk add --no-cache ${PACKAGE} && \
    apk add --no-cache ${DOWNLOAD_PACKAGE} -t buildpack

# entrykit install
RUN wget -q --no-check-certificate ${ENTRYKIT_DOWNLOAD} -O- | tar zx && \
    chmod +x /entrykit && mv /entrykit /usr/bin && /usr/bin/entrykit --symlink

# gosu
RUN wget -q --no-check-certificate ${GOSU_DOWNLOAD} -O /usr/bin/gosu && chmod +x /usr/bin/gosu

# s6-overlay
RUN tar zxf /tmp/s6-overlay-amd64.tar.gz -C /

# conda install
RUN wget -q --no-check-certificate ${CONDA_URL} && \
    bash /${MINICONDA} -b -p ${CONDA_BASE} && \
    ln -s ${CONDA_BASE}/bin/* /usr/local/bin/ && \
    rm -rf /root/.[acpw]* /${MINICONDA} ${CONDA_BASE}/pkgs/* && \
    conda update -q -y conda && conda install -y ${CONDA_PACKAGE} && conda clean -itpsly

RUN apk del buildpack --no-cache && rm -rf /tmp/* /var/cache/apk/*

# add admin user
RUN adduser -D -h /home/admin -s /bin/bash admin admin

# sudoers setting
RUN echo "admin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

WORKDIR ${WORK_DIR}
ENTRYPOINT ["switch","shell=/bin/bash","--","/init"]
CMD ["/bin/bash"]
