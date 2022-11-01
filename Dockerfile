FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    git \
    curl \
    build-essential \
    nasm \
    yasm \
    gcc \
    clang \
    cmake \
    binutils \
    lldb \
&& apt-get upgrade -y \
&& curl -o ~/vsls-reqs https://aka.ms/vsls-linux-prereq-script && chmod +x ~/vsls-reqs && ~/vsls-reqs \
&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/lib/local/lib/python3.10 && ln -s /usr/lib/llvm-14/lib/python3.10/dist-packages /usr/lib/local/lib/python3.10/dist-packages

WORKDIR /playground/src
RUN git clone https://github.com/fluent/fluent-bit.git

RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history" \
&& echo $SNIPPET >> "/root/.bashrc"
