FROM ubuntu:22.04

RUN apt update && \
    apt-get update && \
    apt install -y curl git ripgrep tar unzip vim wget

RUN wget https://github.com/neovim/neovim/releases/download/v0.10.3/nvim-linux64.tar.gz && \
    tar -zxvf nvim-linux64.tar.gz && \
    mv nvim-linux64/bin/nvim usr/bin/nvim && \
    mv nvim-linux64/lib/nvim usr/lib/nvim && \
    mv nvim-linux64/share/nvim/ usr/share/nvim && \
    rm -rf nvim-linux64 && \
    rm nvim-linux64.tar.gz

RUN curl -fsSLO https://deno.land/install.sh && \
    DENO_INSTALL=/usr/local sh install.sh v2.1.4 && \
    rm install.sh

RUN mkdir -p ~/.cache/dpp/repos/github.com/Shougo/ && \
    cd ~/.cache/dpp/repos/github.com/Shougo/ && \
    git clone https://github.com/Shougo/dpp.vim -b v4.1.0 && \
    git clone https://github.com/Shougo/dpp-ext-installer -b v1.3.0 && \
    git clone https://github.com/Shougo/dpp-protocol-git -b v1.1.1 && \
    git clone https://github.com/Shougo/dpp-ext-lazy -b v1.5.0 && \
    git clone https://github.com/Shougo/dpp-ext-toml -b v1.3.0

RUN apt install -y locales && \
    locale-gen ja_JP.UTF-8

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - &&\
    apt install -y nodejs

RUN nvim +:q
