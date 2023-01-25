if !exists("*QuickFixToggle")
    function! QuickFixToggle()
        if empty(filter(getwininfo(), 'v:val.quickfix'))
            copen
        else
            cclose
        endif
    endfunction
endif

if !exists("*ExploreWorking")
    function! ExploreWorking()
        let cwd = getcwd()
        execute ":Explore" l:cwd
    endfunction
endif

if !exists("*LoadProjectVimrc")
    function! LoadProjectVimrc()
        let vimrcFile = findfile(".vimrc", ".;")
        if !empty(l:vimrcFile)
            execute ":so" l:vimrcFile
            echom "A project specific vimrc has been loaded."
        endif
    endfunction
endif
autocmd DirChanged * :call LoadProjectVimrc()
