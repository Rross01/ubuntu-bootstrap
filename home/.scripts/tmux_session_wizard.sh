#!/bin/bash

FZF_OPTS="--bind=alt-k:up,alt-j:down"

function tmux_session_wizard() {
    PLACES_TO_FZF="
        $HOME/ \
        $HOME/.config \
        $HOME/Nextcloud \
        $HOME/temp \
        $HOME/places/apps \
        $HOME/places/personal \
        $HOME/places/work \
        $HOME/places/personal/git \
        $HOME/places/work/git"

    RESULT=$( (tmux list-sessions -F "#{session_name}: #{session_windows} window(s)\
        #{?session_grouped, (group ,}\
        #{session_group}#{?session_grouped,),}\
        #{?session_attached, (attached),}";
        find -L $PLACES_TO_FZF -mindepth 1 -maxdepth 1 -type d) | fzf $FZF_OPTS --layout=reverse | tail -n 1)

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
}

tmux_session_wizard
