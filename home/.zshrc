ZSH_THEME="fwalch"
HYPHEN_INSENSITIVE="true"
HISTFILE=~/places/.zsh_history
HISTFILESIZE=1000000000
HISTSIZE=1000000000
plugins=(zsh-autosuggestions)

# zoxide
eval "$(zoxide init zsh)"
export _ZO_FZF_OPTS="--bind=alt-k:up,alt-j:down --layout=reverse --no-color"

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
alias x='ranger --cmd="set show_hidden true"'
alias git_clean='git checkout master && git pull && git branch | grep -v master | xargs git branch -D $argv'
alias git_log='git log --all --decorate --oneline --graph $argv'
alias getpass="head /dev/urandom | tr -dc \"A-Za-z0-9@#!()&'\" | head -c 16 | wl-copy"
alias locconf='export KUBECONFIG=~/places/kubeconfigs/loc.conf'
alias dark='~/.scripts/toggle.sh dark'
alias light='~/.scripts/toggle.sh light'

python_venv() {
    MYVENV=./venv
    # when you cd into a folder that contains $MYVENV
    [[ -d $MYVENV ]] && source $MYVENV/bin/activate > /dev/null 2>&1
    # when you cd into a folder that doesn't
    [[ ! -d $MYVENV ]] && deactivate > /dev/null 2>&1
}
autoload -U add-zsh-hook
add-zsh-hook chpwd python_venv

python_venv
