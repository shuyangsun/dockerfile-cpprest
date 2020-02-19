FROM conanio/gcc9-jnlp-slave:1.20.3

RUN sudo mkdir /conan
WORKDIR /conan
COPY conanfile.txt ./
RUN sudo mkdir build
WORKDIR /conan/build
RUN sudo /opt/pyenv/shims/conan install .. --build boost
