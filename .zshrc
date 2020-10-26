# For emacs tramp
# see http://www.emacswiki.org/emacs/TrampMode#toc8
[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt histignorealldups histignorespace extendedhistory sharehistory

# Completion
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Ansible
# generate hosts from ansible
# set ansible_hostfiles in ~/.zshenv
# e.g ansible_hostfiles=( ~/ansible/playbook1/hosts ~/ansible/playbook2/hosts )
# local hosts_cache=~/.zsh_hosts_cache
# local -a ansible_hostfiles_new
# for hostfile in $ansible_hostfiles
# do
#     if [ ! -e $hosts_cache -o "$hostfile" -nt $hosts_cache ]
#     then
#         ansible_hostfiles_new=( $ansible_hostfiles_new $hostfile )
#     fi
# done
# if [ "$#ansible_hostfiles_new" -gt 0 ]
# then
#     echo -n > $hosts_cache
#     for hostfile in $ansible_hostfiles
#     do
#         local ansible_dir=$(dirname $hostfile)
#         pushd "$ansible_dir" >& /dev/null
#         ansible \* --inventory-file="$hostfile" --list-hosts | sed -e 's/ //g' >> $hosts_cache
#         popd
#     done
# fi
# zmodload zsh/mapfile
# local hosts
# hosts=( "${(f)mapfile[$hosts_cache]}" )
# zstyle ':completion:*:*:*' hosts $hosts
# short function and alias
ap() {
    ansible-playbook "$@"
}
alias apl='ap --list-tasks --list-hosts'
kas() {
    pkill -f "ssh: ${HOME}/.ansible/cp/"
}

# Set title for ssh in tmux
if [ -n "$TMUX" ]
then
    ssh() {
        tmux rename-window "$*"
        command ssh "$@"
        tmux rename-window "zsh"
    }
fi

ssh_config_hosts() {
    local -a config_hosts
    local config
    for config in ~/.ssh/config.d/*
    do
        if [[ -r $config ]]
        then
            local key hosts host
            while IFS=$'=\t ' read -r key hosts
            do
                if [[ "$key" == Host ]]
                then
                    for host in ${(z)hosts}
                    do
                        case $host in
                            (*[*?]*) ;;
                            (*) config_hosts+=("$host") ;;
                        esac
                    done
                fi
            done < "$config"
        fi
    done
    zstyle ':completion:*:*:*' hosts $config_hosts
}
test -d ~/.ssh/config.d/ && ssh_config_hosts

# Pager
export PAGER="less"
export LESS="-isFMRX# 2"

# Editor
#export EDITOR="emacsclient"
#export ALTERNATE_EDITOR="vim"
#export GIT_EDITOR=$EDITOR
vi() {
    if [ ! -e /usr/bin/emacs ]
    then
        vim "$@"
    elif [ ! -e "/tmp/emacs$(id -u)/server" ]
    then
        if [ x"$DISPLAY" = x ]; then
            emacs "$@"
        else
            nohup emacs "$@" >& /dev/null &
        fi
    else
        emacsclient --no-wait "$@"
    fi
}
# disable <C-s> <C-q> for vim
vim() {
    stty -ixon
    command vim "$@"
    stty ixon
}

# Alias
alias ls='ls --color'
alias au='sudo aptitude -u'
alias se='sudoedit'
alias eg='GIT_DIR=${HOME}/.eg GIT_WORK_TREE=${HOME} git'
alias croot='cd "$(git rev-parse --show-toplevel)"'
alias dmesg='sudo dmesg'
# alias vi=$EDITOR

# Debian packaging staff
export DEBEMAIL="azuwis@gmail.com"
export DEBFULLNAME="Zhong Jianxin"

if [ "$TERM" = "xterm" -o "$TERM" = "linux" ]
then
    # Workaround for lilyterm/lxterminal
    export TERM="xterm-256color"
fi

# SSH agent
sa() {
    if [ x"$SSH_AUTH_SOCK" = x ]
    then
        SSH_AUTH_SOCK="$(find /tmp/ssh-*/ -maxdepth 1 -type s -name 'agent.*' -user "$USER" -printf '%T@ %p\n' 2>/dev/null | sort -n | tail -1 | cut -d' ' -f2)"
        if [ x"$SSH_AUTH_SOCK" != x ]
        then
            export SSH_AUTH_SOCK
        else
            eval "$(ssh-agent -s)"
        fi
    fi
    if ! ssh-add -l >/dev/null
    then
        ssh-add
    fi
    # if [ -S ${HOME}/.gnupg/S.gpg-agent ]
    # then
    #     GPG_AGENT_INFO="${HOME}/.gnupg/S.gpg-agent:0:1"
    #     export GPG_AGENT_INFO
    # fi
}

# Zgen
source /usr/share/zgen/zgen.zsh

if ! zgen saved
then
    echo "Creating a zgen save"

    # Substring search
    zgen load zsh-users/zsh-history-substring-search
    # More completions
    zgen load zsh-users/zsh-completions src
    # Pure prompt
    zgen load mafredri/zsh-async
    zgen load sindresorhus/pure
    # Syntax highlight
    zgen load /usr/share/zsh-syntax-highlighting
    # Auto suggestions
    zgen load /usr/share/zsh-autosuggestions

    zgen save
fi

# Substring search
# Bind UP and DOWN arrow keys
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down
# Bind P and N for EMACS mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
# Bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Ctrl+Backspace to delete word
backward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle backward-kill-word
}
zle -N backward-kill-dir
bindkey '^H' backward-kill-dir

# Pure prompt
PURE_GIT_PULL=0

# Fasd
if command -v fasd >/dev/null 2>&1
then
    eval "$(fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install posix-alias)"
    alias c='fasd_cd -d'
fi

#if [ -f /etc/profile.d/vte-2.91.sh ]
#then
#    source /etc/profile.d/vte-2.91.sh
#fi
