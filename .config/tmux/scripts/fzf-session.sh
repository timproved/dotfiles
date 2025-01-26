#!/usr/bin/env bash

# Function to create new tmux session or switch to existing one
create_or_switch_session() {
    local dir=$1
    local session_name=$(basename "$dir" | tr '.' '_')

    # Check if session exists
    if ! tmux has-session -t="$session_name" 2>/dev/null; then
        # Create new session if it doesn't exist
        tmux new-session -d -s "$session_name" -c "$dir"
    fi

    # If we're already in tmux, switch to the session
    if [ -n "$TMUX" ]; then
        tmux switch-client -t "$session_name"
    else
        tmux attach-session -t "$session_name"
    fi
}

# Use fd if available (faster), fallback to find
if command -v fd >/dev/null 2>&1; then
    dirs=$(fd . ~/dev -t d -d 3)
else
    dirs=$(find ~/dev -type d -maxdepth 3)
fi

# Use fzf to select directory
selected=$(echo "$dirs" | fzf --height 40% --reverse --border rounded \
    --preview 'tree -L 1 {}' \
    --header 'Select directory to create/switch tmux session')

# Exit if no selection made
if [ -z "$selected" ]; then
    exit 0
fi

create_or_switch_session "$selected"
