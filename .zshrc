# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
POWERLINE_NO_BLANK_LINE="true"
POWERLINE_DETECT_SSH="true"
ZSH_THEME="powerline"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git debian extract command-not-found history-substring-search last-working-dir per-directory-history colored-man web-search zsh-syntax-highlighting)

# zsh-completions
fpath=(~/.oh-my-zsh/custom/zsh-completions/src $fpath)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
DEFAULT_USER="azuwis"

# Alias
alias au='sudo aptitude -u'
alias se='sudoedit'

# Disable the annoying auto correction
unsetopt correct_all

# Debian packing staff
export DEBEMAIL="azuwis@gmail.com"
export DEBFULLNAME="Zhong Jianxin"

# Load custom dircolors
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Set title for ssh in tmux
if [ -n "$TMUX" ]; then
    ssh() {
        tmux rename-window "$*"
        command ssh "$@"
    }
fi

# Disable <C-s> <C-q> for vim
vim() {
    stty -ixon
    command vim "$@"
    stty ixon
}
