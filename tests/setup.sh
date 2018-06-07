tests:clone vendor .
tests:require $_tests_base_dir/vim-tests.bash

tests:make-tmp-dir ".vim/bundle"

tests:make-tmp-dir "workspace"
tests:cd "workspace"
