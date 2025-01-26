#!/usr/bin/env bash

create_or_switch_session() {
    local dir=$1
    local session_name=$(basename "$dir" | tr '.' '_')

    if ! tmux has-session -t="$session_name" 2>/dev/null; then
        tmux new-session -d -s "$session_name" -c "$dir" "cd $dir && /bin/zsh"
    fi

    if [ -n "$TMUX" ]; then
        tmux switch-client -t "$session_name"
    else
        tmux attach-session -t "$session_name"
    fi
}

# Find directories in ~/dev with depth 1
if command -v fd >/dev/null 2>&1; then
    dirs=$(fd . ~/dev -t d -d 2)
else
    dirs=$(find ~/dev -type d -maxdepth 1)
fi

selected=$(echo "$dirs" | fzf --height 40% --reverse --border rounded \
    --preview 'tree -L 1 {}' \
    --header 'Select directory to create/switch tmux session')

[ -z "$selected" ] && exit 0

create_or_switch_session "$selected"
