FROM youske/alpine-stdmachine:glibc

ENV CONDA_DIR="/miniconda"
ENV PATH="$CONDA_DIR/bin:$PATH"

WORKDIR /tmp

RUN CONDA_VERSION="latest" && \
    mkdir -p "$CONDA_DIR" && \
    wget "https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh" -O installer.sh && \
    bash installer.sh -f -b -p "$CONDA_DIR" && \
    echo "export PATH=$CONDA_DIR/bin:\$PATH" > /etc/profile.d/conda.sh && \
    conda update --all --yes && conda clean --all --yes && \
    apk del --purge .build-dependencies && rm -rf /tmp/* /root/.wget-hists

WORKDIR /
