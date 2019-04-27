FROM ubuntu:bionic

RUN apt-get update && \
    apt-get install -y wget sudo && \
    rm -rf /var/lib/apt/lists/*

RUN cd /tmp && \
    wget -qO dogecoin.tgz https://github.com/dogecoin/dogecoin/releases/download/v1.14-rc-1/dogecoin-1.14.0-x86_64-linux-gnu.tar.gz && \
    tar zxvf dogecoin.tgz --strip-components=1 -C / && \
    useradd -m crypto && \
    su -c "mkdir /home/crypto/dogecoin/" crypto && \
    rm -vf dogecoin.tgz

ADD dogecoin.conf /home/crypto/dogecoin.conf
ADD start /start

VOLUME /home/crypto/dogecoin/
EXPOSE 6969 22556

ENTRYPOINT ["/start"]
