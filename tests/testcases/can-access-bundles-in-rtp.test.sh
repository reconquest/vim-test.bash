tests:make-tmp-dir .vim/bundle/plugin_a/autoload/
tests:make-tmp-dir .vim/bundle/plugin_b/pythonx/

tests:put .vim/bundle/plugin_a/autoload/plugin_a.vim <<VIML
fun plugin_a#X()
    iabbrev x x-men
endfun
VIML

tests:put .vim/bundle/plugin_b/pythonx/b.py <<PY
import vim

def x():
    vim.command("normal! a: rise of phoenix")
PY

tests:eval tree ../.vim

vim-tests:start "$_vim_session" <<VIMRC
set rtp+=$(vim-tests:get-rtp $(tests:get-tmp-dir)/.vim/bundle)
VIMRC

vim-tests:type "$_vim_session" ":call plugin_a#X()" "enter"

vim-tests:type "$_vim_session" "ix the movie" "escape"
vim-tests:type "$_vim_session" ":py import b; b.x()" "enter"

tests:eval tmux:cat-screen "$_vim_session"

vim-tests:write-file "$_vim_session" "movie"

tests:eval "cat movie"
tests:assert-stdout "x-men the movie: rise of phoenix"

vim-tests:end "$_vim_session"
