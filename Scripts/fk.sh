fk() {
    # Updated to use fdfind - ripgrep find alternative for faster, now significantly better
    local selected

    selected=$(cd /home/prlpnrpph512/Documents && fdfind --type d | fzf --tiebreak=length)

    if [[ -n $selected ]]; then
        cd "/home/prlpnrpph512/Documents/$selected"
    fi
}
