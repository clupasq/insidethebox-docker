
function ensure_world_created() {
    if [ -d "~/.minetest/worlds/world/" ]; then
        echo "World seems to already be set up."
        return
    fi

    echo "Setting up default insidethebox world..."
    mkdir -p ~/.minetest
    # Copy a minimal working ITB world
    cp -r /var/lib/temp/default-game-data/* ~/.minetest
}

function copy_localmusic() {
    if [ -d "~/.minetest/worlds/world/worldmods/localmusic" ]; then
        echo "Localmusic already set up."
        return
    fi

    echo "Setting up Localmusic..."
    mkdir -p ~/.minetest/worlds/world/worldmods/
    cp -r /usr/local/share/minetest/games/insidethebox/mods/music/localmusic ~/.minetest/worlds/world/worldmods/
}

ensure_world_created

copy_localmusic

/usr/local/bin/minetestserver \
    --config ~/.minetest/minetest.conf \
    --gameid insidethebox

