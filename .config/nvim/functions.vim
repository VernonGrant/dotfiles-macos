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

if !exists("*ClippingsPrepare")
    function! ClippingsPrepare()
        normal gg0
        execute ":g!/http/d"
        execute ":sort"
        execute ":sort u"
    endfunction
endif

if !exists("*ShowHighlightGroup")
    function! ShowHighlightGroup()
        for i1 in synstack(line("."), col("."))
            let i2 = synIDtrans(i1)
            let n1 = synIDattr(i1, "name")
            let n2 = synIDattr(i2, "name")
            echo n1 "->" n2
        endfor
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
