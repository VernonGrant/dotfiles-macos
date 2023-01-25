let mapleader="\<Space>"

set colorcolumn=80
set exrc
set linebreak
set noswapfile
set nowrap
set number
set relativenumber
set shell=/bin/bash
set ul=1000
set autoread
set cursorline

" Spell checking.
set spelllang=en
set spell

" File encodings.
set fileencoding=utf-8
set fileencodings=ucs-bom,utf8,prc

" Matching patterns are ignored when expanding wild cards.
set wildignore+=*.so,*.o,*.zip,*.pdf,*.png,*.jpg,*.jpeg
set wildignore+=*/.git/*,*/node_modules/*,*/vendor/*,*/venv/*

" Set tab widths.
set tabstop=4
set shiftwidth=4
set expandtab

" LSP:
" TODO: might fix the column gap issues.
set signcolumn=no

" Netrw.
let g:netrw_preview=1

" Show white spaces using the following characters.
set list listchars=nbsp:¬,tab:»·,trail:·,extends:>

" Influence how Vim formats text, don't insert comment leader on new lines.
set formatoptions-=cro
autocmd FileType * set formatoptions-=cro

" Trim trailing spaces on save.
autocmd BufWritePre * :%s/\s\+$//e

" Theming
syntax enable
