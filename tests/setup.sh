tests:clone vendor .
tests:involve vim-tests.bash

tests:make-tmp-dir ".vim/bundle"

tests:make-tmp-dir "workspace"
tests:cd "workspace"
