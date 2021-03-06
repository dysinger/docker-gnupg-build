#-*- mode: conf -*-

FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get -y install apt-utils
RUN apt-get -y install build-essential
RUN apt-get -y install bzip2
RUN apt-get -y install file
RUN apt-get -y install gettext
RUN apt-get -y install libbz2-dev
RUN apt-get -y install libcurl4-gnutls-dev
RUN apt-get -y install libgnutls-dev
RUN apt-get -y install libldap2-dev
RUN apt-get -y install libncurses-dev
RUN apt-get -y install libreadline-dev
RUN apt-get -y install libsqlite3-dev
RUN apt-get -y install libtinfo-dev
RUN apt-get -y install libusb-dev
RUN apt-get -y install pkg-config
RUN apt-get -y install sqlite3
RUN apt-get -y install texinfo
RUN apt-get -y install wget
RUN apt-get -y install zlib1g-dev

RUN gpg --keyserver pool.sks-keyservers.net --recv-keys 0x4F25E3B6
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys 0xE0856959
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys 0x33BD3F06
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys 0x7EFD60D9

ENV GNUPG 2.1.11
WORKDIR /usr/local/src
RUN wget -c https://www.gnupg.org/ftp/gcrypt/gnupg/gnupg-$GNUPG.tar.bz2
RUN wget -c https://www.gnupg.org/ftp/gcrypt/gnupg/gnupg-$GNUPG.tar.bz2.sig
RUN gpg --verify gnupg-$GNUPG.tar.bz2.sig
RUN tar xf gnupg-$GNUPG.tar.bz2
WORKDIR gnupg-$GNUPG
RUN perl -p -i -e 's/disable-g13/enable-g13/g' build-aux/speedo.mk
RUN make -f build-aux/speedo.mk native INSTALL_PREFIX=/usr/local

ENV PINENTRY 0.9.7
WORKDIR /usr/local/src
RUN wget -c https://www.gnupg.org/ftp/gcrypt/pinentry/pinentry-$PINENTRY.tar.bz2
RUN wget -c https://www.gnupg.org/ftp/gcrypt/pinentry/pinentry-$PINENTRY.tar.bz2.sig
RUN gpg --verify pinentry-$PINENTRY.tar.bz2.sig
RUN tar xf pinentry-$PINENTRY.tar.bz2
WORKDIR pinentry-$PINENTRY
RUN ./configure --prefix=/usr/local --enable-pinentry-curses
RUN make install

WORKDIR /
RUN ldconfig
