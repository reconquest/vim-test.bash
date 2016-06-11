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

vim-test:start "$_vim_session" <<VIMRC
set rtp+=$(vim-test:get-rtp $(tests:get-tmp-dir)/.vim/bundle)
VIMRC

vim-test:type "$_vim_session" ":call plugin_a#X()" "enter"

vim-test:type "$_vim_session" "ix the movie" "escape"
vim-test:type "$_vim_session" ":py import b; b.x()" "enter"

tests:eval tmux:cat-screen "$_vim_session"

vim-test:write-file "$_vim_session" "movie"

tests:eval "cat movie"
tests:assert-stdout "x-men the movie: rise of phoenix"

vim-test:end "$_vim_session"
