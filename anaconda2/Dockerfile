FROM youske/alpine-stdmachine-glibc:latest
MAINTAINER youske miyakoshi <youske@gmail.com>

LABEL com.stdmachine.description="alpine anaconda2 image" \
      com.stdmachine.role="anaconda2 image"

ENV CONDA_DIR="/conda"
ENV PATH="$CONDA_DIR/bin:$PATH"

WORKDIR /tmp
RUN CONDA_VERSION="4.2.0" && \
    mkdir -p "$CONDA_DIR" && \
    wget -q "https://repo.continuum.io/archive/Anaconda2-${CONDA_VERSION}-Linux-x86_64.sh" -O installer.sh && \
    bash installer.sh -f -b -p "$CONDA_DIR" && \
    echo "export PATH=$CONDA_DIR/bin:\$PATH" > /etc/profile.d/conda.sh && \
    conda update --all --yes && conda clean --all --yes && \
    rm -rf /tmp/* /root/.wget-hists

WORKDIR /
