ZSH_THEME="fwalch"
HYPHEN_INSENSITIVE="true"
HISTFILE=~/places/.zsh_history
HISTFILESIZE=1000000000
HISTSIZE=1000000000
plugins=(zsh-autosuggestions)

# Change default editor
export EDITOR="nvim"

# Sources
source <(helm completion zsh)
source <(kubectl completion zsh)
source $HOME/places/sys/oh-my-zsh/oh-my-zsh.sh

# Different home for gpg
export GNUPGHOME="~/places/gpg"

# awscli config file
export AWS_CONFIG_FILE="~/places/.aws_credentials"

# Aliases
alias s='ssh'
alias v='nvim'
alias vim='nvim'
alias kl='kubectl'
alias git_clean='git checkout master && git pull && git branch | grep -v master | xargs git branch -D $argv'
alias git_log='git log --all --decorate --oneline --graph $argv'
alias getpass="head /dev/urandom | tr -dc \"A-Za-z0-9@#!()&'\" | head -c 16 | wl-copy"

# Batcat
BAT_THEME="Monokai Extended"
alias bat='batcat'
# Use batcat for all help pages
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

python_venv() {
    MYVENV=./.venv
    # when you cd into a folder that contains $MYVENV
    [[ -d $MYVENV ]] && source $MYVENV/bin/activate > /dev/null 2>&1
    # when you cd into a folder that doesn't
    [[ ! -d $MYVENV ]] && deactivate > /dev/null 2>&1
}
autoload -U add-zsh-hook
add-zsh-hook chpwd python_venv

python_venv
