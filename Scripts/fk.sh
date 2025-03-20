fk() {
    local selected
    selected=$(find . -type d -not -path '*/\.*' -not -path '*/Large*' | fzf)
    if [[ -n $selected ]]; then
        cd "$selected"
    fi
}
