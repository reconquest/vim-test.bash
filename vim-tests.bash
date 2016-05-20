_base_dir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
source $_base_dir/vendor/github.com/reconquest/tmux.bash/tmux.bash

vim-tests:start() {
    local session=$1

    cat > .vimrc

    tests:debug "vimrc"
    _tests_indent "vimrc" "<empty>" < .vimrc

    tmux:new-session "$session" "vim" -u .vimrc -U NONE
}

vim-tests:end() {
    vim-tests:type "escape" "escape" ":qa!"

    tmux:kill-session "$1"
}

vim-tests:get-rtp() {
    find "$1" -type d -mindepth 1 -maxdepth 1 | paste -sd,
}

vim-tests:type() {
    local session=$1
    shift

    for keys in "${@}"; do
        tmux:send "$session" "$keys"
    done
}

vim-tests:write-file() {
    local session=$1
    local filename=$2

    vim-tests:type "$session" "escape" "escape" ":w $filename" "enter"
}
