
FROM youske/alpine-stdmachine:glibc

LABEL com.stdmachine.description="alpine anaconda2 image" \
      com.stdmachine.role="anaconda2 image"

ENV CONDA_DIR="/anaconda"
ENV PATH="$CONDA_DIR/bin:$PATH"

WORKDIR /tmp

# Install conda
RUN CONDA_VERSION="4.1.1" && \
    CONDA_MD5_CHECKSUM="f7bb3c0ccf23c9789bb895335aa68bf3" && \
    \
    apk add --no-cache --virtual=.build-dependencies bash && \
    \
    mkdir -p "$CONDA_DIR" && \
    wget "http://repo.continuum.io/archive/Anaconda2-${CONDA_VERSION}-Linux-x86_64.sh" -O anaconda.sh && \
    echo "$CONDA_MD5_CHECKSUM  anaconda.sh" | md5sum -c && \
    bash anaconda.sh -f -b -p "$CONDA_DIR" && \
    echo "export PATH=$CONDA_DIR/bin:\$PATH" > /etc/profile.d/conda.sh && \
    \
    conda update --all --yes && conda clean --all --yes && \
    rm -rf $(find "$CONDA_DIR/pkgs/" -maxdepth 1 -name "python-3*" | sort | head -n -1) && \
    \
    apk del --purge .build-dependencies && rm -rf /tmp/*

WORKDIR /
