FROM debian:stable-slim

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    gnupg \
    locales \
    ripgrep \
    tar \
    unzip \
    vim \
    wget \
    build-essential \
    ruby-dev \
    rubygems && \
    echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen && \
    rm -rf /var/lib/apt/lists/*

# Install Neovim
RUN wget https://github.com/neovim/neovim/releases/download/v0.11.5/nvim-linux-x86_64.tar.gz && \
    tar -zxvf nvim-linux-x86_64.tar.gz && \
    mv nvim-linux-x86_64/bin/nvim usr/bin/nvim && \
    mv nvim-linux-x86_64/lib/nvim usr/lib/nvim && \
    mv nvim-linux-x86_64/share/nvim/ usr/share/nvim && \
    rm -rf nvim-linux-x86_64 && \
    rm nvim-linux-x86_64.tar.gz

# Install Deno
RUN curl -fsSLO https://deno.land/install.sh && \
    DENO_INSTALL=/usr/local sh install.sh v2.6.4 && \
    rm install.sh

# Install DPP repositories
RUN mkdir -p ~/.cache/dpp/repos/github.com/Shougo/ && \
    cd ~/.cache/dpp/repos/github.com/Shougo/ && \
    git clone https://github.com/Shougo/dpp.vim -b v5.3.0 && \
    git clone https://github.com/Shougo/dpp-ext-installer -b v2.2.0 && \
    git clone https://github.com/Shougo/dpp-protocol-git -b v2.0.0 && \
    git clone https://github.com/Shougo/dpp-ext-lazy -b v2.0.1 && \
    git clone https://github.com/Shougo/dpp-ext-toml -b v2.0.1

RUN mkdir -p ~/.cache/dpp/repos/github.com/vim-denops/ && \
    cd ~/.cache/dpp/repos/github.com/vim-denops/ && \
    git clone https://github.com/vim-denops/denops.vim -b v8.0.1

# Clone dotfiles
RUN git clone -b main https://github.com/tamago3keran/dotfiles_for_docker.git dotfiles

# Setup configuration symlinks
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

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash - && \
    apt-get install -y --no-install-recommends nodejs && \
    rm -rf /var/lib/apt/lists/*

# Install Language Servers and Ruby Gems
RUN npm install -g @johnnymorganz/stylua-bin && \
    npm install -g vim-language-server && \
    npm install -g pyright && \
    npm install -g typescript typescript-language-server vscode-langservers-extracted && \
    gem install solargraph

# Initialize Neovim configuration
RUN nvim --headless +"call jobstart(['nvim', '--headless', '+call dpp#make_state(\"~/.cache/dpp\", \"~/.config/dpp/dpp.ts\")', '+qall'])" +"call timer_start(15000, {-> execute('qall')})"
RUN nvim --headless +"call dpp#async_ext_action('installer', 'install')" +"call timer_start(45000, {-> execute('qall')})"
