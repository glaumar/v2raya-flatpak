#!/bin/bash
if [ $USER = root ] ; then
    v2raya -c $XDG_CONFIG_HOME/v2raya --reset-password 
else
    return_msg=$( flatpak-spawn --host pkexec sh -c "pkill v2raya; flatpak run --command=reset-password.sh  io.github.glaumar.v2raya_flatpak" )
    
    if [ "$(echo "$return_msg" | tail -1)" =  "Succeed. It will work after you restart v2rayA." ];then
        gdbus call --session \
            --dest=org.freedesktop.Notifications \
            --object-path=/org/freedesktop/Notifications \
            --method=org.freedesktop.Notifications.Notify \
            "" 0 "" 'V2raya reset password successfully!' 'Please restart v2raya.' \
            '[]' '{"urgency": <1>}' 5000
    else
        gdbus call --session \
            --dest=org.freedesktop.Notifications \
            --object-path=/org/freedesktop/Notifications \
            --method=org.freedesktop.Notifications.Notify \
            "" 0 "" 'V2raya' "$return_msg" \
            '[]' '{"urgency": <1>}' 5000
    fi
fi