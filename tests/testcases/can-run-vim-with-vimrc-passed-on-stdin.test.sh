vim-test:start "$_vim_session" <<VIMRC
iabbrev x x-men
VIMRC

vim-test:type "$_vim_session" "ix the movie" "escape"
vim-test:type "$_vim_session" ":iabbrev" "enter"
vim-test:write-file "$_vim_session" "movie"

tests:eval tmux:cat-screen "$_vim_session"

tests:assert-test -e "movie"
tests:assert-test -s "movie"

tests:eval "cat movie"
tests:assert-stdout "x-men the movie"

vim-test:end "$_vim_session"
