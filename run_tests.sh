#!/bin/bash

_base_dir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
source $_base_dir/vendor/github.com/reconquest/test-runner.bash/test-runner.bash

_vim_session=vim-test-$RANDOM

:cleanup() {
    tmux kill-session -t "$_vim_session" 2>/dev/null
}

trap ":cleanup" EXIT

test-runner:run "${@}"
