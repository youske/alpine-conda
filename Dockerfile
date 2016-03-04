# Alpine Linux glibc with conda
# frolvlad/alpine-glibc based

FROM frolvlad/alpine-glibc
MAINTAINER youske miyakoshi <youske@gmail.com>
ENV PATH=/opt/conda/bin:$PATH \
    LANG=C.UTF-8 \
    GOSU=https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64 \
    MINICONDA=Miniconda-latest-Linux-x86_64.sh \
    CONDAURL=https://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh \
    APKINSTALL='bash wget libstdc++'
RUN adduser -D -h /home/admin -s /bin/bash admin admin && \
    apk add --no-cache ${APKINSTALL}
RUN wget -q --no-check-certificate -O /usr/local/bin/gosu ${GOSU} && \
    chmod +x /usr/local/bin/gosu
RUN wget -q --no-check-certificate ${CONDAURL} && \
    bash /${MINICONDA} -b -p /opt/conda && \
    ln -s /opt/conda/bin/* /usr/local/bin/ && \
    rm -rf /root/.[acpw]* /${MINICONDA} /opt/conda/pkgs/* && \
    conda update -q -y conda && \
    conda install virtualenv && \
    conda clean -itpsly

COPY entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
VOLUME /home/admin
WORKDIR /home/admin
CMD ["bash"]
