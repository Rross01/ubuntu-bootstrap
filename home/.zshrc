# zsh settings
ZSH_THEME="fwalch"
HYPHEN_INSENSITIVE="true"
HISTFILE=~/places/.zsh_history
HISTFILESIZE=1000000000
HISTSIZE=1000000000
plugins=(
    git
    zsh-autosuggestions
)
export ZSH="$HOME/places/sys/oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# Change default editor
export EDITOR="nvim"

# Functions
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

# Sources
source <(helm completion zsh)
source <(kubectl completion zsh)

# awscli config file
export AWS_CONFIG_FILE="~/places/.aws_credentials"
# kubeconfs
alias locconf='export KUBECONFIG=~/places/personal/kubeconfigs/loc.conf'

# Aliases
alias s='ssh'
alias v='nvim'
alias vim='nvim'
alias kl='kubectl'
alias x='ranger'
alias git_clean='git checkout master && git pull && git branch | grep -v master | xargs git branch -D $argv'
alias git_log='git log --all --decorate --oneline --graph $argv'

# autoload python venv
python_venv() {
  MYVENV=./venv
  # when you cd into a folder that contains $MYVENV
  [[ -d $MYVENV ]] && source $MYVENV/bin/activate > /dev/null 2>&1
  # when you cd into a folder that doesn't
  [[ ! -d $MYVENV ]] && deactivate > /dev/null 2>&1
}
python_venv

autoload -U add-zsh-hook
add-zsh-hook chpwd python_venv
