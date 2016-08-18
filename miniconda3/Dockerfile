FROM youske/alpine-stdmachine:glibc

ENV CONDA_DIR="/conda"
ENV PATH="$CONDA_DIR/bin:$PATH"

WORKDIR /tmp

RUN CONDA_VERSION="4.1.11" && \
    mkdir -p "$CONDA_DIR" && \
    wget "https://repo.continuum.io/miniconda/Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh" -O installer.sh && \
    bash installer.sh -f -b -p "$CONDA_DIR" && \
    echo "export PATH=$CONDA_DIR/bin:\$PATH" > /etc/profile.d/conda.sh && \
    conda update --all --yes && conda clean --all --yes && \
    rm -rf $(find "$CONDA_DIR/pkgs/" -maxdepth 1 -name "python-3*" | sort | head -n -1) && \
    rm -rf /tmp/* /root/.wget-hists

WORKDIR /
