autoload -Uz colors && colors


ps1_user="%(!.%{$fg[red]%}.%{$fg[green]%})%n"
ps1_host="%{$fg[blue]%}%M"
ps1_remote_host="%{$fg[red]%}%M"
ps1_remote_prefix="%{$fg[red]%}R>"
ps1_path="%{$fg[cyan]%}[%~]"
ps1_suffix="%(?.%{$fg[green]%}.%{$fg[red]%})%(!.#.$)"
ps1_prefix=""

if [ -n "$LEVELS_OF_VIM" ]; then
    ps1_prefix="$ps1_prefix%B%{$fg[red]%}(VIM+$LEVELS_OF_VIM)%{$reset_color%}%b "
fi

if [ -z "$SSH_CLIENT" ]; then
    # Local login
    PS1="$ps1_prefix%B$ps1_user $ps1_host%b$ps1_path%B$ps1_suffix%{$reset_color%}%b "
else
    # Login through SSH
    PS1="$ps1_prefix%B$ps1_remote_prefix$ps1_user $ps1_remote_host%b$ps1_path%B$ps1_suffix%{$reset_color%}%b "
fi

autoload -U compaudit compinit
zmodload zsh/complist
setopt auto_menu
setopt complete_in_word
setopt always_to_end
zstyle ':completion:*:*:*:*:*' menu select

# yoinked from https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/completion.zsh
# case insensitive (all), partial-word and substring completion
if [[ "$CASE_SENSITIVE" = true ]]; then
  zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'
else
  if [[ "$HYPHEN_INSENSITIVE" = true ]]; then
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
  else
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
  fi
fi
unset CASE_SENSITIVE HYPHEN_INSENSITIVE

# Complete . and .. special directories
zstyle ':completion:*' special-dirs true

zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR

# Don't complete uninteresting users
# zstyle ':completion:*:*:*:users' ignored-patterns \
#        adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
#        clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
#        gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
#        ldap lp mail mailman mailnull man messagebus  mldonkey mysql nagios \
#        named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
#        operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
#        rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
#        usbmux uucp vcsa wwwrun xfs '_*'

# ... unless we really want to.
zstyle '*' single-ignored show
# zstyle ':completion:*' menu select
compinit

HISTSIZE=50000
SAVEHIST=10000
HISTFILE="$HOME/.cache/zsh/zsh_history"
# Share history between terminals
setopt SHARE_HISTORY
# Don't store history entries that start with a space
setopt HIST_IGNORE_SPACE

# Change word-selection style to be like bash. This makes alt+backspace delete "bar" in "foo/bar" instead of the entire thing.
autoload -U select-word-style
select-word-style bash

export LESSHISTFILE="$XDG_CONFIG_HOME"/less/history
export PATH="$(yarn global bin):$PATH"
export DIFFPROG="nvim -d"
ZSH_THEME="poop"

plugins=(docker vi-mode)

source $ZSH/oh-my-zsh.sh

[ -f "$HOME/.config/zsh/aliasrc" ] && source "$HOME/.config/zsh/aliasrc"
[ -f "$HOME/.config/zsh/zsh_commands" ] && source "$HOME/.config/zsh/zsh_commands"
KEYTIMEOUT=1

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
      exec startx
fi
