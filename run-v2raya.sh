#!/bin/bash
address=${V2RAYA_ADDRESS:="0.0.0.0:2017"}
port=$(echo "$address" | cut -d':' -f2)

v2raya_is_running() {
    flatpak-spawn --host pgrep -x v2raya > /dev/null
    return $?
}

if [ $USER = root ] ; then
    v2raya -c $XDG_CONFIG_HOME/v2raya -a "$address" --log-file $XDG_CACHE_HOME/v2raya/v2raya.log
elif ! v2raya_is_running; then
    flatpak-spawn --host pkexec flatpak run --env=V2RAYA_ADDRESS="$address" io.github.glaumar.v2raya-deck &
    while ! v2raya_is_running; do
        sleep 1
    done
    sleep 2
    xdg-open "http://localhost:$port"
else
    xdg-open "http://localhost:$port"
fi