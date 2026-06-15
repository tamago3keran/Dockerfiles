FROM ubuntu:24.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates curl git locales ripgrep tar unzip vim wget build-essential && \
    rm -rf /var/lib/apt/lists/* && \
    locale-gen ja_JP.UTF-8

RUN curl -fsSL https://github.com/neovim/neovim/releases/download/v0.12.3/nvim-linux-x86_64.tar.gz \
        -o nvim-linux-x86_64.tar.gz && \
    tar -zxf nvim-linux-x86_64.tar.gz && \
    mv nvim-linux-x86_64/bin/nvim /usr/bin/nvim && \
    mv nvim-linux-x86_64/lib/nvim /usr/lib/nvim && \
    mv nvim-linux-x86_64/share/nvim/ /usr/share/nvim && \
    rm -rf nvim-linux-x86_64 nvim-linux-x86_64.tar.gz

RUN git clone --depth 1 -b v0.23.1 https://github.com/tree-sitter/tree-sitter-ruby.git && \
    gcc -o ruby.so \
        -I tree-sitter-ruby/src \
        tree-sitter-ruby/src/parser.c \
        tree-sitter-ruby/src/scanner.c \
        -shared -Os -fPIC && \
    mkdir -p ~/.local/share/nvim/site/parser && \
    mv ruby.so ~/.local/share/nvim/site/parser/ && \
    rm -rf tree-sitter-ruby

RUN curl -fsSLO https://deno.land/install.sh && \
    DENO_INSTALL=/usr/local sh install.sh v2.8.3 && \
    rm install.sh

RUN mkdir -p ~/.cache/dpp/repos/github.com/Shougo/ && \
    cd ~/.cache/dpp/repos/github.com/Shougo/ && \
    git clone -b v5.3.0 https://github.com/Shougo/dpp.vim && \
    git clone -b v2.2.0 https://github.com/Shougo/dpp-ext-installer && \
    git clone -b v2.0.0 https://github.com/Shougo/dpp-protocol-git && \
    git clone -b v2.0.1 https://github.com/Shougo/dpp-ext-lazy && \
    git clone -b v2.0.1 https://github.com/Shougo/dpp-ext-toml

RUN mkdir -p ~/.cache/dpp/repos/github.com/vim-denops/ && \
    git clone --depth 1 -b v8.0.2 https://github.com/vim-denops/denops.vim ~/.cache/dpp/repos/github.com/vim-denops/denops.vim


RUN git clone -b main https://github.com/tamago3keran/dotfiles_for_docker.git dotfiles

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

RUN nvim --headless +"call jobstart(['nvim', '--headless', '+call dpp#make_state(\"~/.cache/dpp\", \"~/.config/dpp/dpp.ts\")', '+qall'])" +"call timer_start(30000, {-> execute('qall')})"
RUN nvim --headless +"call dpp#async_ext_action('installer', 'install')" +"call timer_start(45000, {-> execute('qall')})"
