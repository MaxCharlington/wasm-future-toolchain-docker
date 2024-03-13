FROM ubuntu:22.04

ENV TOOLS=/opt/tools
ENV PATH=$TOOLS/bin:$PATH
WORKDIR $TOOLS

RUN apt update
RUN apt install -y autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex \
    texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev cmake ninja-build
RUN apt install -y git

RUN git clone --recursive https://github.com/riscv/riscv-gnu-toolchain
RUN cd riscv-gnu-toolchain && ./configure --prefix=$TOOLS --with-arch=rv32gc --with-abi=ilp32d --enable-multilib && make -j4

RUN git clone --recursive https://github.com/WebAssembly/wabt
RUN cd wabt && git submodule update --init && make gcc-release-no-test -j4

WORKDIR /work
