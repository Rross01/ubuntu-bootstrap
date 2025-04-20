#!/bin/bash

export FZF_DEFAULT_OPTS='--bind=alt-k:up,alt-j:down --tmux 40%,30%'

DIRS_TO_FIND="\
$HOME \
$HOME/.config \
$HOME/temp \
$HOME/places/git/personal/ \
$HOME/places/git/work/ \
$HOME/places/git/work/launchpad/ \
$HOME/places/sys/"

TMUX_LIST_FORMAT="\
#{session_name}: #{session_windows} window(s)\
#{?session_grouped, (group ,}\
#{session_group}#{?session_grouped,),}\
#{?session_attached, (attached),}\
"

TMUX_SESSIONS=$(tmux list-sessions -F "$TMUX_LIST_FORMAT")
DIRS_LIST=$(find $DIRS_TO_FIND -mindepth 1 -maxdepth 1 -type d)

RESULT=$((echo "$TMUX_SESSIONS"; echo "$DIRS_LIST") | fzf | tail -n 1)

if [ -z "$RESULT" ]; then
    exit 0
fi

# Get or create session
if [[ $RESULT == *":"* ]]; then
    # RESULT comes from list-sessions
    SESSION=$(echo $RESULT | awk '{print $1}')
    SESSION=${SESSION//:/}
else
    # RESULT is a path
    SESSION=$(basename "$RESULT" | tr . - | tr ' ' - | tr ':' - | tr '[:upper:]' '[:lower:]')
    if ! tmux has-session -t=$SESSION 2> /dev/null; then
        tmux new-session -d -s $SESSION -c "$RESULT"
    fi
fi

# Attach to session
if [ -z "$TMUX" ]; then
    tmux attach -t $SESSION
else
    tmux switch-client -t $SESSION
fi
