#!/bin/bash

FZF_OPTS="--bind=alt-k:up,alt-j:down"

function ssh_search() {
    HOST="$(find -L ~/.ssh/ -type f -name 'config' -or -name '*conf' | \
        xargs grep ^Host | cut -d' ' -f2- | fzf $FZF_OPTS | cut -d' ' -f 1)"
    ssh "$HOST"
    unset HOST
}
ssh_search
