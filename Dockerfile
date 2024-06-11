# Use the latest Ubuntu LTS image as the base
FROM ubuntu:latest

# Set the maintainer label (optional)
LABEL maintainer="your-email@example.com"

# Update and install basic utilities including zsh
RUN apt-get update && \
    apt-get install -y \
    curl \
    git \
    tmux \
    unzip \
    zsh \
    fonts-powerline \
    locales \
    gcc \
    neovim \
    cmake \
    libssl-dev \
    pkg-config \
    libclang-dev \
    libpq-dev \
    build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Generate locale
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Clone and install Nerd Fonts (FiraCode as an example)
RUN git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git && \
    cd nerd-fonts && \
    ./install.sh FiraCode && \
    cd .. && \
    rm -rf nerd-fonts && \
    fc-cache -fv

# Install oh-my-zsh for a nicer zsh experience
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install tmux plugin manager (tpm)
RUN git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Change the default shell to zsh
RUN chsh -s $(which zsh)

# Install Rust and Cargo
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Add Rust and Cargo to the PATH
ENV PATH="/root/.cargo/bin:${PATH}"

# Install Sui from MystenLabs
RUN cargo install --locked --git https://github.com/MystenLabs/sui.git --branch testnet sui

# Update Rust to stable
RUN rustup update stable

# Install move-analyzer language server
RUN cargo install --git https://github.com/MystenLabs/sui move-analyzer

# Create the directory for move-analyzer binary and copy it there
RUN mkdir -p /root/.sui/bin && \
    cp /root/.cargo/bin/move-analyzer /root/.sui/bin/move-analyzer

# Set the default command to run zsh
CMD ["zsh"]
