FROM shuys/cmake:3.15.5

RUN apk update
RUN apk add git linux-headers
RUN apk add boost-dev
RUN apk add libressl-dev
# RUN apk add asio-dev
RUN apk add ninja
RUN apk add zlib-dev
RUN apk add make

WORKDIR /

COPY asio-1.12.2.tar.bz2 ./asio-1.12.2.tar.bz2
RUN tar xjf asio-1.12.2.tar.bz2 && rm asio-1.12.2.tar.bz2
WORKDIR asio-1.12.2
RUN ./configure
RUN make install

# RUN apk add websocket++


WORKDIR /

RUN git clone --branch 0.8.1 https://github.com/zaphoyd/websocketpp.git
WORKDIR websocketpp
RUN cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr . && make install

WORKDIR /

RUN git clone https://github.com/Microsoft/cpprestsdk.git casablanca
WORKDIR /casablanca

RUN sed 's/\ \-\<Werror\>//g' Release/src/CMakeLists.txt >> CMakeListsNew.txt
RUN mv CMakeListsNew.txt Release/src/CMakeLists.txt

RUN mkdir build.release && cd build.release && cmake .. -DCMAKE_BUILD_TYPE=Release && make
RUN make install

CMD ["./test_runner", "*_test.so"]
