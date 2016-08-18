
FROM youske/alpine-stdmachine:glibc

LABEL com.stdmachine.description="alpine anaconda3 image" \
      com.stdmachine.role="anaconda3 image"

ENV CONDA_DIR="/anaconda"
ENV PATH="$CONDA_DIR/bin:$PATH"

WORKDIR /tmp

# Install conda
RUN CONDA_VERSION="4.1.1" && \
    CONDA_MD5_CHECKSUM="d0dc08d241f83ffc763504db50008e5b" && \
    \
    apk add --no-cache --virtual=.build-dependencies bash && \
    \
    mkdir -p "$CONDA_DIR" && \
    wget "http://repo.continuum.io/archive/Anaconda3-${CONDA_VERSION}-Linux-x86_64.sh" -O anaconda.sh && \
    echo "$CONDA_MD5_CHECKSUM  anaconda.sh" | md5sum -c && \
    bash anaconda.sh -f -b -p "$CONDA_DIR" && \
    echo "export PATH=$CONDA_DIR/bin:\$PATH" > /etc/profile.d/conda.sh && \
    \
    conda update --all --yes && conda clean --all --yes && \
    rm -rf $(find "$CONDA_DIR/pkgs/" -maxdepth 1 -name "python-3*" | sort | head -n -1) && \
    \
    apk del --purge .build-dependencies && rm -rf /tmp/*

WORKDIR /
