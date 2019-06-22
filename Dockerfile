FROM debian

#идем в папку
WORKDIR /usr/src

# Update and install vim using apk
RUN apt-get update && apt-get install -y git build-essential cmake libssl-dev liblua5.2-dev gperf libconfig++-dev  zlib1g-dev ccache && \
    git clone --recursive https://github.com/vysheng/tdbot.git && cd ./tdbot && git submodule update --remote --merge && \
    cd .. && mkdir tdbot-build && cd tdbot-build &&  cmake --parallel -DCMAKE_BUILD_TYPE=Release ../tdbot && make -j4 telegram-bot && make install && \
    apt-get remove -y git build-essential cmake && apt-get autoremove -y && \
    rm -R -f /usr/src/tdbot && rm -R -f /usr/src/tdbot-build

CMD /usr/local/bin/telegram-bot $CMD
