ARG UBUNTU_VERSION=22.04

FROM ubuntu:${UBUNTU_VERSION} as base

ARG USERNAME

ENV LANG="ja_JP.UTF-8"
ENV LANGUAGE="ja_JP:ja"
ENV LC_ALL="ja_JP.UTF-8"
ENV TZ="JST-9"
# tmux経由で256色描画できるようにする
ENV TERM="xterm-256color"

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
        ca-certificates \
        ctop \
        curl \
        docker.io \
        git \
        htop \
        language-pack-ja \
        make \
        shellcheck \
        software-properties-common \
        sudo \
        tmux \
        unzip \
        vim \
        wget \
        zsh \
    && add-apt-repository -y ppa:git-core/ppa \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ARG USER_UID=1000
ARG USER_GID=$USER_UID



# Create the user
RUN groupadd --gid $USER_GID ${USERNAME} \
    && useradd -s $(which zsh) --uid $USER_UID --gid $USER_GID -m ${USERNAME} \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo \
    && gpasswd -a ${USERNAME} docker \
    && echo ${USERNAME} ALL=\(ALL\) NOPASSWD:ALL > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME}


# dotfiles
ENV HOME /home/${USERNAME}
WORKDIR $HOME
USER ${USERNAME}

RUN ln -s ~/work/dotfiles/zsh/.zshrc ~/.zshrc \
    && ln -s ~/work/dotfiles/zsh/.zsh_aliases ~/.zsh_aliases

RUN mkdir -p $HOME/.vscode-server/extensions \
    && chown -R ${USERNAME} $HOME/.vscode-server

# FROM base as node
USER root
WORKDIR /tmp
RUN curl -SL https://deb.nodesource.com/setup_18.x | bash \
    && apt-get install nodejs \
    && npm install -g -y npm-check-updates

# FROM base as rust
WORKDIR /tmp
RUN apt-get install -y gcc
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
# RUN echo 'source $HOME/.cargo/env' >> $HOME/.bashrc

# FROM base as python
USER root
RUN apt-get install -y python3-distutils
USER ${USERNAME}
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -
ENV PATH $PATH:${HOME}/.poetry/bin


# ********************************************************
# * Anything else you want to do like clean up goes here *
# ********************************************************

# [Optional] Set the default user. Omit if you want to keep the default as root.

USER ${USERNAME}
