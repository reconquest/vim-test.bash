vim-tests:start "$_vim_session" <<< ""

vim-tests:write-file "$_vim_session" "empty"

tests:eval tmux:cat-screen "$_vim_session"

tests:assert-test -e "empty"
tests:assert-test ! -s "empty"

vim-tests:end "$_vim_session"
