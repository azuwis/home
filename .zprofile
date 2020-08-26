# Add ~/bin to PATH
if [ -d "$HOME/bin" ]
then
    export PATH="$HOME/bin:$PATH"
fi

# Add ~/go/bin to PATH
if [ -d "$HOME/go/bin" ]
then
    export PATH="$HOME/go/bin:$PATH"
fi

tty="$(tty)"
if [ -z "$DISPLAY" ] && [ "$tty" = "/dev/tty1" ] && [ -x /usr/bin/startx ]
then
    # Start X if at tty1, extra args are copied from startx code
    if [ -f /etc/X11/Xresources/ansible-managed ]
    then
        dpi="$(awk '/^Xft\.dpi/ {print $2}' /etc/X11/Xresources/ansible-managed)"
    fi
    if [ -n "$dpi" ]
    then
        exec startx -- :0 vt1 -keeptty -nolisten tcp -dpi "$dpi"
    else
        exec startx
    fi
elif [ -z "$WAYLAND_DISPLAY" ] && [ "$tty" = "/dev/tty2" ] && [ -x /usr/bin/sway ]
then
    # Start sway if at tty2
    ### gtk
    export GDK_BACKEND=wayland
    export CLUTTER_BACKEND=wayland
    ### qt
    export QT_QPA_PLATFORM=wayland-egl
    #export QT_QPA_PLATFORMTHEME=gtk2
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    ### sdl
    export SDL_VIDEODRIVER=wayland
    ### java
    export _JAVA_AWT_WM_NONREPARENTING=1
    ### fcitx
    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS=@im=fcitx
    ### firefox
    export MOZ_USE_XINPUT2=1
    ### sway
    exec ssh-agent sway
    #exec ssh-agent sway -d 2> ~/.sway.log
fi
