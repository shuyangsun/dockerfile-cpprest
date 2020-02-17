FROM shuys/cmake:3.15.5

RUN apk update
# RUN apk add boost
RUN apk add git linux-headers
RUN apk add boost-dev
RUN apk add libressl-dev
RUN apk add websocket++
RUN apk add ninja
RUN apk add zlib-dev
# RUN apk add libboost-atomic-dev libboost-thread-dev libboost-system-dev libboost-date-time-dev libboost-regex-dev libboost-filesystem-dev libboost-random-dev libboost-chrono-dev libboost-serialization-dev libwebsocketpp-dev openssl libssl-dev ninja-build

WORKDIR /
RUN git clone https://github.com/Microsoft/cpprestsdk.git casablanca
WORKDIR /casablanca

RUN mkdir build.release && cd build.release && cmake -G Ninja .. -DCMAKE_BUILD_TYPE=Release && ninja
RUN ninja install

CMD ["./test_runner", "*_test.so"]
