# For emacs tramp
# see http://www.emacswiki.org/emacs/TrampMode#toc8
[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return

# Set up the prompt

autoload -Uz promptinit
promptinit

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=20000
SAVEHIST=20000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

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
#     if [ ! -e $hosts_cache -o "$hostfile" -nt $hosts_cache ]; then
#         ansible_hostfiles_new=( $ansible_hostfiles_new $hostfile )
#     fi
# done
# if [ "$#ansible_hostfiles_new" -gt 0 ]; then
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


# Set title for ssh in tmux
if [ -n "$TMUX" ]; then
    ssh() {
        tmux rename-window "$*"
        command ssh "$@"
        tmux rename-window "zsh"
    }
fi

# Editor
export EDITOR="emacsclient"
export ALTERNATE_EDITOR="vim"
export GIT_EDITOR=$EDITOR
vi() {
    if [ ! -e /usr/bin/emacs ]; then
        vim "$@"
    elif [ ! -e /tmp/emacs$(id -u)/server ]; then
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
# alias vi=$EDITOR

# Debian packaging staff
export DEBEMAIL="azuwis@gmail.com"
export DEBFULLNAME="Zhong Jianxin"

test $TERM = "xterm" && {
    # Workaround for lilyterm/lxterminal
    export TERM="xterm-256color"
    # Set terminal color scheme
    # Note: Hack here, xtermcontrol will only run once when lxterminal
    # startup, as TERM is set to xterm-256color after this
    xtermcontrol --file=~/.config/xtermcontrol/zenburn.conf
}

# Antigen
if [ ! -d ~/.antigen ]; then
    mkdir ~/.antigen
    git clone https://github.com/zsh-users/antigen.git ~/.antigen/antigen
fi
source ~/.antigen/antigen/antigen.zsh

# Substring search
antigen bundle zsh-users/zsh-history-substring-search
# Bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
# Bind P and N for EMACS mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
# Bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# More completions
antigen bundle zsh-users/zsh-completions

# Colorful manpage
antigen bundle colored-man

# Pure prompt
PURE_GIT_PULL=0
antigen bundle sindresorhus/pure

# Tell antigen that you're done.
antigen apply

syntax_highlighting="/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
if [ -e "$syntax_highlighting" ]; then
    source "$syntax_highlighting"
fi
