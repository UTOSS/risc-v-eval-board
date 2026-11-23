FROM ubuntu:26.04

ARG DEBIAN_FRONTEND=noninteractive
ARG KEYRING_PATH=/usr/share/keyrings
ARG APT_SOURCES_PATH=/etc/apt/sources.list.d

# update and upgrade
RUN apt update && apt upgrade -y

# install essentialls
RUN apt update && \
    apt install -y \
    man make build-essential git zsh vim curl wget procps gnupg gnupg2 ca-certificates zip \
    software-properties-common

# unminimize the system
RUN bash -c "yes | unminimize"

# create dev sudo user
RUN if id ubuntu >/dev/null 2>&1; then userdel -r ubuntu; fi && \
    useradd --create-home dev && \
    usermod --append --groups sudo dev && \
    apt update && apt install -y sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Install the current KiCad stable series and an Xorg-based XFCE desktop for XRDP.
# Update the PPA series when KiCad publishes a new major stable release.
RUN add-apt-repository -y ppa:kicad/kicad-10.0-releases && \
    apt-get update && \
    apt-get install -y xfce4 xfce4-goodies xrdp xorgxrdp dbus-x11 \
        x11-xserver-utils kicad && \
    adduser xrdp ssl-cert && \
    printf '%s\n' 'exec startxfce4' > /home/dev/.xsession && \
    chown dev:dev /home/dev/.xsession && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 3389

# install dumb init system
USER root
RUN apt update && apt install -y dumb-init

# setup oh-my-zsh
USER dev
ARG DOCKER_OHMYZSH_SCRIPT_NAME=zsh-in-docker.sh
ARG DOCKER_OHMYZSH_SCRIPT_URL=https://github.com/deluan/zsh-in-docker/releases/download/v1.1.3/${DOCKER_OHMYZSH_SCRIPT_NAME}
ARG DOCKER_OHMYZSH_SCRIPT_HASH="ffa8175332ef01b500ace59d03ce7e2f3a7453651e9a37060974bb6536f0706b  ${DOCKER_OHMYZSH_SCRIPT_NAME}"
RUN cd /tmp && \
    wget ${DOCKER_OHMYZSH_SCRIPT_URL} && \
    echo ${DOCKER_OHMYZSH_SCRIPT_HASH} | sha256sum -c && \
    chmod +x ./${DOCKER_OHMYZSH_SCRIPT_NAME} && \
    ./${DOCKER_OHMYZSH_SCRIPT_NAME} -t robbyrussell -p git -p ssh-agent && \
    rm ./${DOCKER_OHMYZSH_SCRIPT_NAME}

USER dev
ENTRYPOINT ["/usr/bin/dumb-init", "--"]


