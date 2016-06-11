vim-test:start "$_vim_session"

vim-test:write-file "$_vim_session" "empty"

tests:eval tmux:cat-screen "$_vim_session"

tests:assert-test -e "empty"
tests:assert-test ! -s "empty"

vim-test:end "$_vim_session"
