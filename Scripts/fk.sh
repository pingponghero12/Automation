fk() {
    local selected
    selected=$(find . -type d -not -path '*/\.*' | fzf)
    if [[ -n $selected ]]; then
        cd "$selected"
    fi
}
