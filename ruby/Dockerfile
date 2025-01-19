FROM ubuntu:24.04

RUN apt update && \
    apt-get update && \
    apt install -y curl git ripgrep tar unzip vim wget gcc

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

RUN mkdir -p ~/.cache/dpp/repos/github.com/vim-denops/ && \
    cd ~/.cache/dpp/repos/github.com/vim-denops/ && \
    git clone https://github.com/vim-denops/denops.vim -b v7.0.4

RUN apt install -y locales && \
    locale-gen ja_JP.UTF-8

RUN git clone -b ruby https://github.com/tamago3keran/dotfiles_for_docker.git dotfiles

RUN rm -f ~/.bashrc && \
    rm -f ~/.config/nvim/init.vim && \
    mkdir -p ~/.config/nvim && \
    ln -s /dotfiles/.bashrc ~/.bashrc && \
    ln -s /dotfiles/.bash_aliases ~/.bash_aliases && \
    ln -s /dotfiles/.config/nvim/init.lua ~/.config/nvim/init.lua && \
    ln -s /dotfiles/.config/dpp ~/.config/dpp && \
    ln -s /dotfiles/.config/tomls ~/.config/tomls && \
    ln -s /dotfiles/.config/hooks ~/.config/hooks && \
    ln -s /dotfiles/.bash_boot_scripts/ ~/.bash_boot_scripts

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - &&\
    apt install -y nodejs && \
    npm install -g @johnnymorganz/stylua-bin

RUN apt install -y build-essential rubygems ruby-dev && gem install solargraph

RUN nvim --headless +"call jobstart(['nvim', '--headless', '+call dpp#make_state(\"~/.cache/dpp\", \"~/.config/dpp/dpp.ts\")', '+qall'])" +"call timer_start(15000, {-> execute('qall')})"
RUN nvim --headless +"call dpp#async_ext_action('installer', 'install')" +"call timer_start(45000, {-> execute('qall')})"
