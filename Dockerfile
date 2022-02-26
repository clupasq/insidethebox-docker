ARG DOCKER_IMAGE=alpine:3.14

# Install luarocks and lsqlite3 (neded for ITB)
FROM $DOCKER_IMAGE AS luarocks

RUN echo "${SOME_OTHER_PARAM:-novalue}"

COPY ./scripts/install-luarocks-lsqlite3.sh /root

RUN /bin/sh /root/install-luarocks-lsqlite3.sh

# Clone the insidethebox game repository
FROM $DOCKER_IMAGE AS gitclone

RUN apk update && apk add git && \
    pwd && \
    git clone https://gitlab.com/clupasq/insidethebox.git

# Start from the official minetest image and add insidethebox
FROM registry.gitlab.com/minetest/minetest/server:5.3.0 AS insidethebox

USER root:root

RUN mkdir -p /var/lib/temp

COPY --from=luarocks /root/luarocks-3.8.0/lua_modules/lib/lua/5.1/lsqlite3.so /usr/local/lib/lua/5.1/lsqlite3.so
COPY --from=gitclone /insidethebox /usr/local/share/minetest/games/insidethebox
COPY ./scripts/start_minetest_server.sh /var/lib/minetest
COPY ./default-game-data/ /var/lib/temp/default-game-data/

RUN chown -R minetest:minetest /var/lib/temp

USER minetest:minetest

CMD ["/bin/sh", "/var/lib/minetest/start_minetest_server.sh"]

