FROM shuys/cmake:3.15.5

RUN apk update
RUN apk add git linux-headers
RUN apk add boost-dev
RUN apk add libressl-dev
RUN apk add websocket++
RUN apk add ninja
RUN apk add zlib-dev
RUN apk add make

WORKDIR /
RUN git clone https://github.com/Microsoft/cpprestsdk.git casablanca
WORKDIR /casablanca

RUN sed 's/\ \-\<Werror\>//g' Release/src/CMakeLists.txt >> CMakeListsNew.txt
RUN mv CMakeListsNew.txt Release/src/CMakeLists.txt

RUN mkdir build.release && cd build.release && cmake .. -DCMAKE_BUILD_TYPE=Release && make
RUN make install

CMD ["./test_runner", "*_test.so"]
