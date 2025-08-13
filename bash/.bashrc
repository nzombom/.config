#!/bin/bash
# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR=nvim
export VISUAL=nvim
export MANPAGER="nvim +Man! -"
export PAGER="nvim +Man! -"

export XDG_DATA_HOME="/home/zombo/.local/share"
export XDG_CONFIG_HOME="/home/zombo/.config"
export XDG_STATE_HOME="/home/zombo/.local/state"
export XDG_CACHE_HOME="/home/zombo/.cache"

export HISTFILE="/dev/null"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export XSERVERRC="$XDG_CONFIG_HOME/X11/xserverrc"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java \
	-Djavafx.cachedir=$XDG_CACHE_HOME/openjfx"

function clonepkg {
	case $1 in
		"artix")
			git clone "https://gitea.artixlinux.org/packages/$2"
			;;
		"arch")
			git clone "https://gitlab.archlinux.org/archlinux/packaging/packages/$2"
			;;
		"aur")
			git clone "https://aur.archlinux.org/$2.git"
			;;
	esac
}
function grepf {
	grep $1 $(find $2 -type f)
}
function cppl {
	cpplint --root=$1/headers \
		--filter=-whitespace/tab,-whitespace/indent,-legal,-build/include_subdir,-runtime/int \
		$(find $1 -type f) 2>&1 >/dev/null | nvim -
}

alias rm='rm -I'
alias ls='ls --color=auto -Gh'
alias gitl='git log --graph --oneline --decorate --all'

function promptSetup {
	function abbrev {
		local len=${#2}
		if [ $len -gt $1 ]; then
			echo ...$(echo $2 | cut -c $(($len - $1 - 3))- -)
		else
			echo $2
		fi
	}
	function ret {
		return $1
	}
	local c="\[\e[0m\]"
	local bt="\[\e[1m\]"
	local bf="\[\e[22m\]"
	local rt="\[\e[7m\]"
	local rf="\[\e[27m\]"
	local fr="\[\e[39m\]"
	local br="\[\e[49m\]"
	local cf="\[\e[91m\]"
	local dir="\$(dirs +0 | perl -n $XDG_CONFIG_HOME/bash/dirs.pl \
		| sed \"s/__BASH_LESC_/\\[/g; s/_BASH_RESC__/\\]/g\")"
	PS1="$cf$bt█$rt[\u@\h] $bf$rf$dir$c "
	PS2="$vb$rbf ░▒▓$c$rbf\$>$c "
}
promptSetup
