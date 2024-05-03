FROM ubuntu:22.04

RUN apt update && \
    apt-get update && \
    apt install -y curl git ripgrep tar unzip vim wget

RUN wget https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-linux64.tar.gz && \
    tar -zxvf nvim-linux64.tar.gz && \
    mv nvim-linux64/bin/nvim usr/bin/nvim && \
    mv nvim-linux64/lib/nvim usr/lib/nvim && \
    mv nvim-linux64/share/nvim/ usr/share/nvim && \
    rm -rf nvim-linux64 && \
    rm nvim-linux64.tar.gz

RUN wget https://raw.githubusercontent.com/Shougo/dein-installer.vim/11e9af56fe00edb06d19ee8e7f8bfb222230699b/installer.sh && \
    sh installer.sh "~/.local/share/dein" --use-neovim-config && \
    rm installer.sh

RUN curl -fsSLO https://deno.land/install.sh && \
    DENO_INSTALL=/usr/local sh install.sh v1.42.2 && \
    rm install.sh

RUN apt install -y locales && \
    locale-gen ja_JP.UTF-8

RUN git clone https://github.com/tamago3keran/dotfiles.git

RUN rm ~/.bashrc && \
    rm ~/.config/nvim/init.vim && \
    ln -s /dotfiles/.bashrc ~/.bashrc && \
    ln -s /dotfiles/.bash_aliases ~/.bash_aliases && \
    ln -s /dotfiles/.config/nvim/init.vim ~/.config/nvim/init.vim && \
    ln -s /dotfiles/.local/share/dein/toml ~/.local/share/dein/toml && \
    ln -s /dotfiles/.local/share/dein/plugins ~/.local/share/dein/plugins && \
    ln -s /dotfiles/.bash_boot_scripts/ ~/.bash_boot_scripts

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - &&\
    apt install -y nodejs && \
    npm install -g pyright

RUN nvim +:q
