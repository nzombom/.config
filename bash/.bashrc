#!/bin/bash
# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR=nvim
export VISUAL=nvim
export MANPAGER="nvim +Man! -"
export PAGER="nvim +Man! -"

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

export HISTFILE="$XDG_STATE_HOME/bash/history"
export XINITRC="$XDG_CONFIG_HOME/x11/xinitrc"
export XSERVERRC="$XDG_CONFIG_HOME/x11/xserverrc"
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
		--filter=-whitespace/tab,-whitespace/indent,-legal,-build/include_subdir,-build/c++17 \
		$(find $1 -type f) 2>&1 >/dev/null | nvim -
}

alias rm='rm -I'
alias cp='cp -i'
alias ls='ls --color=auto -hFNT 4 --group-directories-first'
alias gitl='git log --graph --oneline --decorate --all'

if [ $TERM = "linux" ]; then
	echo -en "\e]P0302c38"
	echo -en "\e]P83c3a40"
	echo -en "\e]P1d05058"
	echo -en "\e]P9ff707c"
	echo -en "\e]P240b058"
	echo -en "\e]Pa60ff78"
	echo -en "\e]P3b09040"
	echo -en "\e]Pbffd080"
	echo -en "\e]P45060c0"
	echo -en "\e]Pc7080ff"
	echo -en "\e]P5b840bc"
	echo -en "\e]Pdf460ff"
	echo -en "\e]P630a09c"
	echo -en "\e]Pe40d4cc"
	echo -en "\e]P7ffffff"
	echo -en "\e]Pfffffff"
	setfont $HOME/.config/bash/ttyFonts/iosevka/iosevkanf.psf
	clear
fi

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
	local cb="\[\e[101m\]"
	local df="\[\e[90m\]"
	local db="\[\e[100m\]"
	local dir="\$(dirs +0 | perl -n $XDG_CONFIG_HOME/bash/dirs.pl \
		| sed \"s/__BASH_LESC__/\\[/g; s/__BASH_RESC__/\\]/g\")"
	local sp="$cb$df  $br$cf$db \$ $df$br$c "
	PS1="$cf$bt$rt \u@\h $bf$rf$cb$dir$c\n$sp"
	PS2="$cb$df $br$df$br█$c "
}
promptSetup
