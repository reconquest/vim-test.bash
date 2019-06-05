if ! declare -f import:use &>/dev/null; then
    _base_dir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
    source $_base_dir/vendor/github.com/reconquest/import.bash/import.bash
fi

import:use github.com/reconquest/tmux.bash

vim-tests:start() {
    local session=$1

    {
        echo "set nocompatible"
        echo "au VimEnter * silent !touch .$session-ready"
        echo
        cat
        echo "set nomore"
    } > .vimrc

    tests:debug "vimrc"
    _tests_indent "vimrc" "<empty>" < .vimrc

    tmux:new-session "$session" "vim" -u .vimrc -U NONE

    while [ ! -e .$session-ready ]; do
        :
    done
}

vim-tests:end-silent() {
    vim-tests:end "${@}" 2>/dev/null || true
}

vim-tests:end() {
    local session=$1
    vim-tests:type "$session" "escape" "escape" ":qa!"

    tmux:kill-session "$1"
}

vim-tests:get-rtp() {
    find "$1" -mindepth 1 -maxdepth 1 -type d | paste -sd,
}

vim-tests:type() {
    local session=$1
    shift

    tmux:send "$session" "${@}"
}

vim-tests:write-file() {
    local session=$1
    local filename=$2

    vim-tests:type "$session" "escape" "escape" ":w $filename" "enter"

    while [ ! -e $filename ]; do
        :
    done
}

vim-tests:get-messages() {
    local session=$1

    vim-tests:type "$session" "escape" "escape" \
        ":let @q=execute('messages')" \
        "enter" \
        ":call writefile(getreg('q', 1, 1), '.$session-messages')" \
        "enter"

    cat .$session-messages
}
