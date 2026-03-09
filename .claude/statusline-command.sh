#!/bin/bash

# Read JSON input from stdin
input=$(cat)

model_display=$(echo "$input" | jq -r '.model.display_name')
current_dir=$(echo "$input" | jq -r '.workspace.current_dir')
context_size=$(echo "$input" | jq -r '.context_window.context_window_size')
current_usage=$(echo "$input" | jq '.context_window.current_usage')
short_dir=$(basename "$current_dir")

# Calculate context window percentage
context_display="0%"
context_color="\033[32m"
if [ "$current_usage" != "null" ] && [ "$context_size" != "null" ]; then
    tokens=$(echo "$current_usage" | jq '.input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens')
    if [ "$tokens" != "null" ] && [ "$context_size" -gt 0 ]; then
        percent=$((tokens * 100 / context_size))
        context_display=" | ${percent}%"
        if [ "$percent" -ge 60 ]; then
            context_color="\033[31m"
        elif [ "$percent" -ge 40 ]; then
            context_color="\033[33m"
        fi
    fi
fi

# Get git branch and status if in a git repository
branch_section=""
if git -C "$current_dir" rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git -C "$current_dir" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null || \
             git -C "$current_dir" --no-optional-locks rev-parse --short HEAD 2>/dev/null)

    if [ -n "$branch" ]; then
        # Check working tree status
        status=$(git -C "$current_dir" --no-optional-locks status --porcelain 2>/dev/null)
        if [ -z "$status" ]; then
            branch_color="\033[32m" # green = clean
        else
            branch_color="\033[33m" # yellow = dirty
        fi

        # Check ahead/behind remote
        arrows=""
        counts=$(git -C "$current_dir" --no-optional-locks rev-list --left-right --count HEAD...@{upstream} 2>/dev/null)
        if [ -n "$counts" ]; then
            ahead=$(echo "$counts" | cut -f1)
            behind=$(echo "$counts" | cut -f2)
            [ "$ahead" -gt 0 ] 2>/dev/null && arrows="${arrows}↑${ahead}"
            [ "$behind" -gt 0 ] 2>/dev/null && arrows="${arrows}↓${behind}"
        fi

        branch_section=$(printf " \033[90m|\033[0m \033[97m⎇\033[0m ${branch_color}%s\033[0m\033[91m%s\033[0m" "$branch" "${arrows:+ $arrows}")
    fi
fi

printf "\033[97m▶\033[0m \033[94m%s\033[0m%s \033[90m|\033[0m \033[97m✨\033[0m \033[36m%s\033[0m (${context_color}%s\033[0m)" \
      "$short_dir" "$branch_section" "$model_display" "${context_display# | }"
