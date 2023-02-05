" Bindings Reminders
" -----------------------------------------------------------------------------
"
" Block Selections:
"
" - <C-v>             | Start block selection.
"
" Folding:
"
" - zf                | Create fold.
" - zo                | Open fold.
" - zc                | Close fold.
" - za                | Toggle fold.
"
" Windows:
"
" - <C-w>o            | Close other windows.
"
" Spelling:
"
" - ]s                | Go to previous spelling mistake.
" - [s                | Go to next spelling mistake.
" - z=                | Show list of spelling correction choices.
" - zg                | Remember current word as correct.
"
" Netrw:
"
" - <C-w> z           | Close the Preview.
" - <F1>              | Causes Netrw to issue help
" - <cr>              | Netrw will enter the directory or read the file
" - <del>             | Netrw will attempt to remove the file/directory
" - -                 | Makes Netrw go up one directory
" - a                 | Toggles between normal display, hiding (suppress display of files matching g:netrw_list_hide) showing (display only files which match g:netrw_list_hide)
" - c                 | Make browsing directory the current directory
" - C                 | Setting the editing window
" - d                 | Make a directory
" - D                 | Attempt to remove the file(s)/directory(ies)
" - gb                | Go to previous bookmarked directory
" - gh                | Quick hide/unhide of dot-files
" - <c-h>             | Edit file hiding list
" - i                 | Cycle between thin, long, wide and tree listings
" - <c-l>             | Causes Netrw to refresh the directory listing
" - mb                | Bookmark current directory
" - mc                | Copy marked files to marked-file target directory
" - md                | Apply diff to marked files (up to 3)
" - me                | Place marked files on arg list and edit them
" - mf                | Mark a file
" - mh                | Toggle marked file suffices' presence on hiding list
" - mm                | Move marked files to marked-file target directory
" - mp                | Print marked files
" - mr                | Mark files satisfying a shell-style
" - mt                | Current browsing directory becomes markfile target
" - mT                | Apply ctags to marked files
" - mu                | Unmark all marked files
" - mx                | Apply arbitrary shell command to marked files
" - mz                | Compress/decompress marked files
" - o                 | Enter the file/directory under the cursor in a new browser window. A horizontal split is used.
" - O                 | Obtain a file specified by cursor
" - p                 | Preview the file
" - P                 | Browse in the previously used window
" - qb                | List bookmarked directories and history
" - qf                | Display information on file
" - r                 | Reverse sorting order
" - R                 | Rename the designed file(s)/directory(ies)
" - s                 | Select sorting style: by name, time or file size
" - S                 | Specify suffix priority for name-sorting
" - t                 | Enter the file/directory under the cursor in a new tab
" - u                 | Change to recently-visited directory
" - U                 | Change to subsequently-visited directory
" - v                 | Enter the file/directory under the cursor in a new browser window. A vertical split is used.
" - x                 | View file with an associated program
" - X                 | Execute filename under cursor via
" - %                 | Open a new file in netrw's current directory
"
" Vim Commenter:
"
" - gcc               | Toggle comment.
"
" Emmet:
"
" - <C-y>,            | Expand emmet sequence, normal mode.
"
" General:
"
" - <leader>e         | Explore current file directory.
" - <leader>.         | Go to next buffer in current window.
" - <leader>,         | Go to previous buffer in current window.

" Marks (Knowing these makes things a lot faster):
"
" - `.                | Jump to position where last change occurred in current buffer.
" - `"                | Jump to position where last exited current buffer.
" - `0                | Jump to position in last file edited (when exited Vim).
" - `1                | Like `0 but the previous file (also `2 etc).
" - ''                | Jump back (to line in current buffer where jumped from).
" - ``                | Jump back (to position in current buffer where jumped from).
" - `[ or `]          | Jump to beginning/end of previously changed or yanked text.
" - `< or `>          | jump to beginning/end of last visual selection.
"
" Yanking And Pasting Across Sessions:
"
" - <leader>dd        | Delete/Cut line to system clipboard.
" - <leader>yy        | Yank line to system clipboard.
" - <leader>d         | Delete/Cut visual selection system clipboard.
" - <leader>y         | Yank visual selection system clipboard.
" - <leader>p         | Past from system clipboard.
"
" Visual Selection:
"
" - o                 | Move between start and end of visual selection.
"
" FZF:
"
" - <C-v>             | Open file in new vertical split.
" - <C-x>             | Open file in new horizontal split.
" - <C-t>             | Open file in new tab.
"
" - <leader>F         | Find file everywhere.
" - <leader>f         | Find and open file in Git repo.
" - <leader>b         | Find and open buffer.
" - <leader>h         | Find old files and open buffers.
" - <leader>l         | Search current file lines.
" - <leader>s         | Search files in project.
"
" Fugitive:
"
" - <leader>gg        | Git status.
" - <leader>gp        | Git push.
" - <leader>gc        | Git checkout branch.
" - <leader>gh        | Git commit history.
" - <leader>gd        | Git diff split.
" - <leader>gb        | Git blame.
"
" Commands:
"
" - norm    | Runs normal commands at point.
"
" Vim Script Reminders:
"
" - system("ls -ltr")
" - :help expand
" - :echo expand("%:p")    " absolute path
" - :echo expand("%:p:h")  " absolute path dirname
" - :echo expand("%:p:h:h")" absolute path dirname dirname
" - :echo expand("%:.")    " relative path
" - :echo expand("%:.:h")  " relative path dirname
" - :echo expand("%:.:h:h")" relative path dirname dirname
" - :echo expand("<sfile>:p")  " absolute path to [this] vim script

" Saving the current buffer using enter.
nnoremap <CR> :w<CR>

" Quickly exit insert mode.
inoremap jj <Esc>
inoremap jk <Esc>
inoremap kk <Esc>

" Help with visual selection indentation.
vnoremap < <gv
vnoremap > >gv

" Disable current highlight.
nnoremap <silent><leader>/ :noh<CR>

" Moving lines.
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Yanking and pasting across sessions.
nmap <leader>dd "+dd
nmap <leader>yy "+yy
nmap <leader>p "+p
nmap <leader>P <left>"+p
vmap <leader>p d<left>"+p
vmap <leader>d "+d
vmap <leader>y "+y

" Substitution
nmap <leader>r :%s/<c-r><c-w>//<left>


" Explore current files folder.
nnoremap <silent> <leader>e :Ex<CR>
nnoremap <silent> <leader>E :call ExploreWorking()<CR>

" Buffers cycling.
nnoremap <silent> <leader>o :bn<CR>
nnoremap <silent> <leader>i :bp<CR>

" FZF
nnoremap <silent> <leader>F :Files<CR>
nnoremap <silent> <leader>f :GFiles<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>h :History<CR>
nnoremap <silent> <leader>l :BLines<CR>
nnoremap <silent> <leader>L :Lines<CR>
nnoremap <silent> <leader>s :Rg<CR>

" TODO: Fix this binding conflict issue.
" Center Pad.
nnoremap <silent> <leader>c <cmd>lua require'centerpad'.toggle { leftpad = 50, rightpad = 50 }<cr>

" Fugitive.
nnoremap <silent> <leader>gg :Git<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gc :GCheckout<CR>
nnoremap <silent> <leader>gh :Commits<CR>
nnoremap <silent> <leader>gd :Gdiffsplit<CR>
nnoremap <silent> <leader>gb :Git blame<CR>

" Quick Fix.
nnoremap <silent><F2> :call QuickFixToggle()<CR>
nnoremap <silent><F3> :cprevious<CR>
nnoremap <silent><F4> :cnext<CR>

" External Programs.
" nnoremap <silent> <leader>xt :!open -a Terminal %:p:h &<CR><CR>
nnoremap <silent> <leader>ct :!kitty %:p:h &<CR><CR>
nnoremap <silent> <leader>ce :!open %:p:h &<CR><CR>

" Load project specific vimrc.
nnoremap <F12> :call LoadProjectVimrc()<CR>

"nnoremap <silent> <leader>ci :r ./
" Insert a file into the current file.
" nnoremap <F11> :r ./

" Notes.
nnoremap <leader>cp :find /Users/vernon/Devenv/projects/<CR>
nnoremap <leader>cn :find /Users/vernon/Devenv/notes/<CR>
nnoremap <leader>ch :find /Users/vernon/<CR>
