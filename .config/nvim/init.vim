set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" Setup instructions
" -----------------------------------------------------------------------------
" Remember to do a :checkhealth
" run: pip install pynvim
"
" In case of shada related error, run this:
" rm ~/.local/share/nvim/shada/*

" Vim configuration files
" -----------------------------------------------------------------------------
source ~/.config/nvim/general.vim
source ~/.config/nvim/functions.vim
source ~/.config/nvim/plugins.vim
source ~/.config/nvim/bindings.vim
