if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
    export SDL_VIDEODRIVER=wayland
    export _JAVA_AWT_WM_NONREPARENTING=1
    export QT_QPA_PLATFORM=wayland
    export XDG_CURRENT_DESKTOP=sway
    export XDG_SESSION_DESKTOP=sway
    echo > /tmp/sway_is_starting
    exec sway
fi

# Add own binaries to the path
export PATH=$PATH:$HOME/.bin:$HOME/.scripts

# zsh settings
ZSH_THEME="robbyrussell"
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
HISTFILE=~/places/.zsh_history
HISTFILESIZE=1000000000
HISTSIZE=1000000000
plugins=(git)
export ZSH="$HOME/places/oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# Sources
source <(helmfile completion zsh)
source <(kubectl completion zsh)

# ssh-agent
export SSH_AUTH_SOCK=/run/user/1000/ssh-agent.socket

# Change default editor
export EDITOR="nvim"

# Functions
check_for_http_status_code() {
    ENDPOINT=$1
    STATUS_CODE=$2
    CHECK=$(curl -L -w '%{response_code}' -s -o /dev/null $ENDPOINT)
    [[ $CHECK = $STATUS_CODE ]]
}

loop() {
    for (( ; ; ))
    do
        zsh -i -c "$1"
        sleep 1
    done
}

loop_wait_for_true() {
    for (( ; ; ))
    do
        date
        zsh -i -c "$1" && break
        sleep 1
    done
}

# Aliases
alias sf='~/.scripts/ssh_search.sh'
alias v='nvim'
alias vim='nvim'
alias gb='git branch'
alias git_clean='git checkout master && git pull && git branch | grep -v master | xargs git branch -D $argv'
alias glog='git log --all --decorate --oneline --graph $argv'
alias kl='kubectl'
alias x='ranger'
