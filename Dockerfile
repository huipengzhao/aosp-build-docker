FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN cat <<EOF >/etc/apt/sources.list
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-backports main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-security main restricted universe multiverse
EOF

# cache apt packages
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && apt-get install -y \
        bc \
        bison \
        build-essential \
        coreutils \
        curl \
        dosfstools \
        e2fsprogs \
        fdisk \
        flex \
        fontconfig \
        git-core \
        gnupg \
        kpartx \
        libncurses5 \
        libgl1-mesa-dev \
        libx11-dev \
        libxml2-utils \
        mtools \
        ninja-build \
        pkg-config \
        python3-pip \
        rsync \
        unzip \
        x11proto-core-dev \
        xsltproc \
        zip \
        zlib1g-dev \
    && \
    pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple \
        meson \
        mako \
        jinja2 \
        ply \
        pyyaml \
        dataclasses

RUN cat <<EOF >/usr/local/bin/entrypoint && chmod +x /usr/local/bin/entrypoint
#!/bin/bash
set -e
useradd -m -s /bin/bash -u \$1 -U \$2
trap "exit 0" TERM
while true ; do sleep 0.2 ; done
EOF

ENTRYPOINT [ "/usr/local/bin/entrypoint" ]
