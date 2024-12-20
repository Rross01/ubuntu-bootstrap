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
alias x='ranger --cmd="set show_hidden true"'
alias git_clean='git checkout master && git pull && git branch | grep -v master | xargs git branch -D $argv'
alias git_log='git log --all --decorate --oneline --graph $argv'
alias getpass="head /dev/urandom | tr -dc \"A-Za-z0-9@#!()&'\" | head -c 16 | wl-copy"
alias locconf='export KUBECONFIG=~/places/personal/kubeconfigs/loc.conf'

wait_for_status_code() {
    ENDPOINT=$1
    EXPECTED_RC=$2
    for (( ; ; ))
    do
        CURRENT_RC=$(curl --connect-timeout 1 -L -w '%{response_code}' -s -o /dev/null $ENDPOINT)
        echo "$(date): URL: $ENDPOINT, return code: $CURRENT_RC"
        [[ $CURRENT_RC = $EXPECTED_RC ]] && break
        sleep 1
    done
    notify-send "$ENDPOINT return $EXPECTED_RC!"
}
