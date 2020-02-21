FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
    g++-9 cmake git \
    libboost-atomic-dev libboost-thread-dev libboost-system-dev \
    libboost-date-time-dev libboost-regex-dev libboost-filesystem-dev \
    libboost-random-dev libboost-chrono-dev libboost-serialization-dev \
    libwebsocketpp-dev openssl libssl-dev ninja-build
RUN git clone https://github.com/Microsoft/cpprestsdk.git --branch v2.10.14 casablanca
WORKDIR casablanca
RUN mkdir build.release
WORKDIR build.release
RUN cmake -G Ninja .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_FIND_LIBRARY_SUFFIXES=".a" \
    -DOPENSSL_USE_STATIC_LIBS=TRUE \
    -DBUILD_SHARED_LIBS=0 \
    -DBUILD_SAMPLES=OFF \
    -DBUILD_TESTS=OFF \
    && ninja

ENV LIBCPPREST_PATH="/build"
ENV LIBCPPREST_BINARY_PATH="/casablanca/build.release/Release/Binaries/libcpprest.a"
ENV LIBCPPREST_INCLUDE_PATH="/casablanca/Release/include"

# RUN mkdir -p "${LIBCPPREST_PATH}" && \
#     mv "/casablanca/build.release/Release/Binaries/libcpprest.a" "${LIBCPPREST_BINARY_PATH}" && \
#     mv "/casablanca/Release/include" "${LIBCPPREST_INCLUDE_PATH}" && \
#     rm -rf casablanca