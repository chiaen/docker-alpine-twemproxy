FROM alpine:latest
RUN apk update && apk add ca-certificates \
  && rm -rf /var/cache/apk/* /tmp/*
RUN apk add --update alpine-sdk autoconf automake libtool \
  && rm -rf /var/cache/apk/* /tmp/*
RUN curl -qL https://github.com/twitter/twemproxy/archive/v0.4.1.tar.gz | tar xzf -
RUN cd twemproxy-0.4.1 && autoreconf -fvi && ./configure --enable-debug=log && make && mv src/nutcracker /usr/local/bin/nutcracker
RUN cd / && rm -rf twemproxy-0.4.1
CMD nutcracker -c /etc/twemproxy/conf.yml
