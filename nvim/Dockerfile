FROM alpine:latest

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
    zsh \
    bash \
    git \
    neovim \
    nodejs \
    npm \
    ruby \
    ruby-dev \
    gcc \
    libc-dev \
    make \
    curl \
    python2 \
    python2-dev \
    python3 \
    python3-dev \
    openssh \
    the_silver_searcher \
    && \
    rm -rf /var/cache/apk/*

RUN npm install -g neovim

RUN gem install neovim

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python2 get-pip.py && \
    python2 -m pip install neovim && \
    python3 get-pip.py && \
    python3 -m pip install neovim && \
    rm get-pip.py

RUN cd ~/.config && \
    git clone https://github.com/tamago3keran/nvim.git

RUN curl -sf https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh | sh -s /root/.cache/dein

RUN nvim +:UpdateRemotePlugins +:LspInstallServer +:q
