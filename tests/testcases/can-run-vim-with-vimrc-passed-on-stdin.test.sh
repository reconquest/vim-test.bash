vim-tests:start "$_vim_session" <<VIMRC
iabbrev x x-men
VIMRC

vim-tests:type "$_vim_session" "ix the movie" "escape"
vim-tests:type "$_vim_session" ":iabbrev" "enter"
vim-tests:write-file "$_vim_session" "movie"

tests:eval tmux:cat-screen "$_vim_session"

tests:assert-test -e "movie"
tests:assert-test -s "movie"

tests:eval "cat movie"
tests:assert-stdout "x-men the movie"

vim-tests:end "$_vim_session"
