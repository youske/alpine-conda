# Alpine Linux glibc with conda
# frolvlad/alpine-glibc based

FROM frolvlad/alpine-glibc
MAINTAINER youske miyakoshi <youske@gmail.com>
ENV PATH=/opt/conda/bin:$PATH \
    LANG=C.UTF-8 \
    MINICONDA=Miniconda-latest-Linux-x86_64.sh \
    APKINSTALL='bash wget libstdc++'
RUN apk add --no-cache $APKINSTALL && \
    wget -q --no-check-certificate https://repo.continuum.io/miniconda/$MINICONDA && \
    bash /${MINICONDA} -b -p /opt/conda && \
    ln -s /opt/conda/bin/* /usr/local/bin/ && \
    rm -rf /root/.[acpw]* /$MINICONDA /opt/conda/pkgs/* && \
    conda update -q -y conda && \
    conda install virtualenv && \
    conda clean -itpsly
RUN adduser -D -h /home/admin -s /bin/bash admin admin && \ 
    adduser -D -h /home/user -s /bin/bash user user 
CMD ["bash"]
EXPOSE 8080
