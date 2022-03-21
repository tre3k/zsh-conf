# User configuration

export PATH=$PATH:/home/kirill/.local/bin
export BROWSER=/usr/bin/firefox
export EDITOR='emacsclient -c'

alias emacs='emacsclient -c'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias su='su -s /usr/bin/zsh'

# auto competation (for args commands)
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select rehash true
# and aliases
setopt completealiases

# correction
setopt correctall

# enable edit-command-line
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey "^x^e" edit-command-line

# enable color
autoload -Uz colors && colors

# for git
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )

# Some unitiltes:
# Only for archlinux with pkgfile
PKGFILE=/usr/bin/pkgfile
if [[ -f "$PKGFILE" ]]; then
    source /usr/share/doc/pkgfile/command-not-found.zsh
fi

# set path to zsh-syntax-highlighting.zsh
SYNTAX_HIGHLIGHTING=/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
if [[ -f "$SYNTAX_HIGHLIGHTING" ]]; then
    source $SYNTAX_HIGHLIGHTING
fi

# grc utilty
if [ -f /usr/bin/grc ]; then
    alias gcc="grc --colour=auto gcc"
    alias irclog="grc --colour=auto irclog"
    alias log="grc --colour=auto log"
    alias netstat="grc --colour=auto netstat"
    alias ping="grc --colour=auto ping"
    alias proftpd="grc --colour=auto proftpd"
    alias traceroute="grc --colour=auto traceroute"
    alias nmap="grc --colour=auto nmap"
fi

function preexec() {

}

function precmd() {
    # case $? in
    # 	0) _error="";;
    # 	130) _error="terminated";;
    # 	*) _error="error";;
    # esac
}

TIMEFMT=$'%J: %E real, %U user, %S sys, %P cpu'

_color_bg=68
_color_fg=236
_color_git_bg=114
_color_rfg=243

if [[ "$UID" == 0 ]]; then
    _color_bg=208
    _color_rfg=124
fi

# COPY like emacs need
if [[ -f "/usr/bin/xsel" ]]; then
    x-copy-region-as-kill () {
	zle copy-region-as-kill
	print -rn $CUTBUFFER | xsel -i -b
    }

    zle -N x-copy-region-as-kill
    x-kill-region () {
	zle kill-region
	print -rn $CUTBUFFER | xsel -i -b
    }

    zle -N x-kill-region
    x-yank () {
	CUTBUFFER=$(xsel -o -b </dev/null)
	zle yank
    }

    zle -N x-yank
    bindkey -e '\ew' x-copy-region-as-kill
    bindkey -e '^W' x-kill-region
    bindkey -e '^Y' x-yank
fi

zstyle ':vcs_info:git:*' formats "%F{$color_fg}%K{$_color_git_bg} %b%K{$_color_bg}%F{$_color_git_bg}%f%k"
setopt prompt_subst
PROMPT='${vcs_info_msg_0_}%F{$_color_fg}%K{$_color_bg} %~ %k%f%F{$_color_bg}%f '
RPROMPT='%F{$_color_rfg} %n@%m%f'