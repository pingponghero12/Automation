fk() {
    local selected
    selected=$(find /home/prlpnrpph512/Documents -type d \
        -not -path '*/Large*' \
        -not -path '*/build*' \
        -not -path '*/.git*' \
        -not -path '*/.venv*' \
        -not -path '*/.github*' \
        -not -path '*/.__pycache__*' \
        -not -path '*/.cache*' \
        -not -path '*/.svn*' \
        -printf '%P\n' \
        | awk '{ print length($0), $0 }' \
        | sort -n \
        | cut -d" " -f2- \
        | fzf)
    if [[ -n $selected ]]; then
        cd "/home/prlpnrpph512/Documents/$selected"
    fi
}
