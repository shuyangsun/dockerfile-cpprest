FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:ubuntu-toolchain-r/test && \
    apt-get install -y git g++-9 cmake make libboost-all-dev libcpprest-dev && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 90 --slave /usr/bin/g++ g++ /usr/bin/g++-9 --slave /usr/bin/gcov gcov /usr/bin/gcov-9

RUN mkdir /usr/lib/x86_64-linux-gnu/cmake/cpprestsdk/ && mv /usr/lib/x86_64-linux-gnu/cmake/*.cmake /usr/lib/x86_64-linux-gnu/cmake/cpprestsdk/
