FROM ubuntu:22.04

RUN apt update && apt install -y curl git ripgrep unzip vim wget

RUN wget https://github.com/neovim/neovim/releases/download/v0.8.2/nvim-linux64.deb && \
    apt install ./nvim-linux64.deb && \
    rm ./nvim-linux64.deb

RUN wget https://raw.githubusercontent.com/Shougo/dein-installer.vim/master/installer.sh && \
    sh installer.sh '~/.local/share/dein' --use-neovim-config && \
    rm installer.sh

RUN curl -fsSL https://deno.land/install.sh | DENO_INSTALL=/usr/local sh

RUN git clone -b react https://github.com/tamago3keran/dotfiles.git

RUN rm ~/.bashrc && \
    rm ~/.config/nvim/init.vim && \
    ln -s /dotfiles/.bashrc ~/.bashrc && \
    ln -s /dotfiles/.bash_aliases ~/.bash_aliases && \
    ln -s /dotfiles/.config/nvim/init.vim ~/.config/nvim/init.vim && \
    ln -s /dotfiles/.local/share/dein/toml ~/.local/share/dein/toml && \
    ln -s /dotfiles/.local/share/dein/plugins ~/.local/share/dein/plugins && \
    ln -s /dotfiles/.bash_boot_scripts/ ~/.bash_boot_scripts

RUN curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh && \
    bash nodesource_setup.sh && \
    rm nodesource_setup.sh && \
    apt install -y nodejs && \
    npm install -g typescript typescript-language-server vscode-langservers-extracted

RUN nvim +:q
