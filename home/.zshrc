ZSH_THEME="fwalch"
HISTFILE=~/places/.zsh_history
HISTFILESIZE=1000000000
HISTSIZE=1000000000
source $HOME/places/sys/oh-my-zsh/oh-my-zsh.sh

export EDITOR="nvim"
export PATH="$HOME/.local/share/nvim/mason/bin/:$PATH"
export GNUPGHOME="~/places/gpg"
export AWS_CONFIG_FILE="~/places/.aws_credentials"
export FZF_DEFAULT_OPTS='--reverse --bind=alt-k:up,alt-j:down --style=minimal --color=16'

# completions
source <(helm completion zsh)
source <(kubectl completion zsh)
source <(dive completion zsh)
source <(fzf --zsh)

# aliases
alias s='ssh'
alias v='nvim'
alias kl='kubectl'
alias git_log='git log --all --decorate --oneline --graph $argv'
alias getpass="head /dev/urandom | tr -dc \"A-Za-z0-9@#!()&'\" | head -c 16 | wl-copy"
alias locconf="export KUBECONFIG=~/places/kubeconfigs/loc.conf"

# batcat for all help pages
alias -g -- -h='-h 2>&1 | batcat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | batcat --language=help --style=plain'

# batcat for man pages
export MANPAGER="sh -c 'col -bx | batcat --language=man --style=plain'"
export MANROFFOPT="-c"

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
    git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D
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
