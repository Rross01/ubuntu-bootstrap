# Setup
ZSH_THEME="fwalch"
HYPHEN_INSENSITIVE="true"
HISTFILE=~/places/.zsh_history
HISTFILESIZE=1000000000
HISTSIZE=1000000000
plugins=(zsh-autosuggestions)
source $HOME/places/sys/oh-my-zsh/oh-my-zsh.sh

# Change default editor
export EDITOR="nvim"

# fzf opts
export FZF_DEFAULT_OPTS='--bind=alt-k:up,alt-j:down --reverse --color=bw'

# Different home for gpg
export GNUPGHOME="~/places/gpg"

# awscli config file
export AWS_CONFIG_FILE="~/places/.aws_credentials"

# Sources
source <(helm completion zsh)
source <(kubectl completion zsh)
source <(fzf --zsh)

# Aliases
alias s='ssh'
alias v='nvim'
alias vim='nvim'
alias kl='kubectl'
alias git_log='git log --all --decorate --oneline --graph $argv'
alias getpass="head /dev/urandom | tr -dc \"A-Za-z0-9@#!()&'\" | head -c 16 | wl-copy"
alias locconf="export KUBECONFIG=~/places/kubeconfigs/loc.conf"

# Batcat
export BAT_THEME="base16"
# Use batcat for all help pages
alias -g -- -h='-h 2>&1 | batcat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | batcat --language=help --style=plain'
# Use batcat for man pages
export MANPAGER="sh -c 'col -bx | batcat --language=man --style=plain'"
export MANROFFOPT="-c"
alias bat='batcat'

git_clean() {
    # master или main
    b=$(git symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null | sed 's@^origin/@@')
    if [ -z "$b" ]; then
        if git branch --list main >/dev/null 2>&1; then
            b=main
        else
            b=master
        fi
    fi
    git checkout "$b" && git pull
    git branch | grep -v -E "^\*|\b($b)\b" | xargs git branch -D
}

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
