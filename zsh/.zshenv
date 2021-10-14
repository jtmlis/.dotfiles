#!/bin/zsh

if command -v nvim > /dev/null 2>&1; then
	export EDITOR=nvim
elif command -v vim > /dev/null 2>&1; then
	export EDITOR=vim
elif command -v emacs > /dev/null 2>&1; then
	export EDITOR=emacsnw
fi

if [[ "$OSTYPE" == "linux"* ]]; then
	export LANG="en_US.UTF-8"
	export LC_CTYPE="en_US.UTF-8"

	export MOZ_USE_XINPUT2=1 # Pixel-perfect trackpads <3
	export MOZ_ENABLE_WAYLAND=1
	export MOZ_DBUS_REMOTE=1

	export IBUS_ENABLE_CTRL_SHIFT_U=1
	export XMODIFIERS="@im=fcitx"

	# This hack necessary for reasons I'll never understand. Under Wayland specifically,
	# GTK themes are evidently only configured through envvars? Whatever, this fixes it.
	export GTK_THEME=$(cat ~/.config/gtk-3.0/settings.ini | grep gtk-theme-name | cut -d'=' -f2)
	export GTK_CSD=0
	export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
	export GTK_IM_MODULE="fcitx"
	#export GDK_BACKEND=wayland

	export CLUTTER_BACKEND=wayland
	#export QT_QPA_PLATFORM=wayland-egl
	export QT_QPA_PLATFORMTHEME=qt5ct
	export QT_IM_MODULE="fcitx"
	export QT_WAYLAND_FORCE_DPI=physical
	export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

	#export SDL_VIDEODRIVER=wayland
	export XDG_CURRENT_DESKTOP=sway
fi

export PMM_WORLD="~/.config/worldedit/$(hostname)"
export HOMEBREW_BREWFILE="~/.config/worldedit/$(hostname)"

export SSH_AUTH_SOCK
export PAGER=less
export PYTHONBREAKPOINT=ipdb.set_trace

