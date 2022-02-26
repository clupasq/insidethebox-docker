#!/bin/sh

apk add curl wget build-base readline-dev unzip sqlite sqlite-dev openssl
cd ~
curl -R -O http://www.lua.org/ftp/lua-5.1.5.tar.gz
tar -zxf lua-5.1.5.tar.gz
cd lua-5.1.5
make linux test
make install
cd ~
wget https://luarocks.org/releases/luarocks-3.8.0.tar.gz
tar zxpf luarocks-3.8.0.tar.gz
cd luarocks-3.8.0
./configure --with-lua-include=/usr/local/include
make
make install
luarocks install lsqlite3


