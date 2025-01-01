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

RUN apt install -y locales && \
    locale-gen ja_JP.UTF-8

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - &&\
    apt install -y nodejs

RUN nvim +:q
