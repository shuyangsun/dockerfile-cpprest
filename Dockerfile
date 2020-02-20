FROM ubuntu:18.04

# RUN apt-get update && \
#     apt-get install -y software-properties-common && \
#     add-apt-repository ppa:ubuntu-toolchain-r/test && \
#     apt-get install -y git g++-9 cmake make libboost-all-dev libcpprest-dev && \
#     update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 90 --slave /usr/bin/g++ g++ /usr/bin/g++-9 --slave /usr/bin/gcov gcov /usr/bin/gcov-9

RUN apt-get update && apt-get install -y g++ cmake git libboost-atomic-dev libboost-thread-dev libboost-system-dev libboost-date-time-dev libboost-regex-dev libboost-filesystem-dev libboost-random-dev libboost-chrono-dev libboost-serialization-dev libwebsocketpp-dev openssl libssl-dev ninja-build
RUN git clone https://github.com/Microsoft/cpprestsdk.git casablanca
WORKDIR casablanca
RUN mkdir build.debug
WORKDIR build.debug
RUN cmake -G Ninja .. -DCMAKE_BUILD_TYPE=Debug
RUN ninja

WORKDIR /casablanca/Release/Binaries
CMD ["./test_runner", "*_test.so"]