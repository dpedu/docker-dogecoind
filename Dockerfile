FROM ubuntu:trusty

WORKDIR /tmp

RUN apt-get update && \
    apt-get install -y supervisor wget unzip && \
    wget -O dogecoin.zip https://github.com/dogecoin/dogecoin/releases/download/v1.10.0-dogeparty/dogecoin-1.10.0-linux64.tar.gz && \
    unzip dogecoin.zip dogecoind && \
    mv dogecoind /usr/local/bin/dogecoind && \
    chmod +x /usr/local/bin/dogecoind && \
    useradd -m crypto && \
    su -c "mkdir /home/crypto/dogecoin/" crypto && \
    rm -rf /tmp/dogecoin.zip /var/lib/apt/lists/*

ADD dogecoin.conf /home/crypto/dogecoin.conf
ADD supervisor-dogecoin.conf /etc/supervisor/conf.d/dogecoin.conf

VOLUME /home/crypto/dogecoin/
EXPOSE 6969 22556

CMD supervisord
