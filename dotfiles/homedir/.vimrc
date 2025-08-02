call plug#begin()

Plug 'c64cosmin/harpwn'
Plug 'mbbill/undotree'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'preservim/nerdcommenter'
Plug 'rluba/jai.vim'

call plug#end()

"
" Automatically set working directory to the one opened with 'vim .'
" This is a workaround for the problem, when I open vim and until I go to any
" file, it thinks I am in the parent directory...
"
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | execute 'cd '.argv()[0] | endif



" Highlighint all leading Tabs
highlight Tab ctermbg=LightBlue guibg=LightBlue
autocmd BufEnter * call matchadd('Tab', '^\t\+', -1)
autocmd InsertLeave * call clearmatches()
" autocmd BufLeave * call clearmatches()

nnoremap <SPACE> <Nop>
let mapleader=" "

" Selecting a whole text
map <Leader>a ggVG

" Undotree and persistent undo by default
nnoremap <Leader>u :UndotreeToggle<CR>
set undofile

" Exiting to current folder
nnoremap <leader>pv :Ex<CR>

 "Find and replace phrase
nnoremap <leader>s :%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>

" Better :retab -> replace indentation in file from tabs to spaces
nnoremap <leader>pi :set expandtab<CR>:retab<CR>

" FuzzyFinder for files
nnoremap <leader>ff :FZF --reverse<CR> 

" FuzzyFinder for content
command! -bang -nargs=* FZCONTENT call fzf#vim#grep('grep -rnI --exclude-dir={.next,.git,node_modules,env} '.shellescape(<q-args>), 0, <bang>0) --reverse
nnoremap <leader>fc :FZCONTENT<CR> 

" Harpwn bindings
nnoremap <silent> <leader>d :HarpwnAdd<CR>
nnoremap <silent> <leader>m :HarpwnMenu<CR>
nnoremap <silent> <C-h> :HarpwnGo 0<CR>
nnoremap <silent> <C-j> :HarpwnGo 1<CR>
nnoremap <silent> <C-k> :HarpwnGo 2<CR>
nnoremap <silent> <C-l> :HarpwnGo 3<CR>

" Bring search results to midscreen
nnoremap n nzz
nnoremap N Nzz

" Keep some lines around cursor when scrolling
set scrolloff=2


" turn hybrid line numbers on
:set number relativenumber
:set nu rnu


syntax enable
set background=dark
set tabstop=8     " Number of spaces that a <Tab> in the file counts for
set softtabstop=8 " Number of spaces that a <Tab> is when editing
set shiftwidth=8  " Number of spaces to use for each step of (auto)indent
set expandtab     " Use spaces instead of tabs
set autoindent    " Copy indent from current line when starting a new line

" Current working directory preview at the bottom
set laststatus=2
set statusline=%F
set statusline+=%=
set statusline+=%{getcwd()}

" Temporarilly disable parenthesis highlighting
"let loaded_matchparen = 1 

" share clipboard with the system
set clipboard=unnamedplus

" highlighting search results
set hlsearch
highlight Search ctermfg=white ctermbg=red
nnoremap A :noh<CR>A
nnoremap a :noh<CR>a
nnoremap I :noh<CR>I
nnoremap i :noh<CR>i

" integrating Vim with i3
"
" I would like to open new console windows in the current Vim directory
" for this to work, we need to write current directory to somewhere so the i3
" can pick it up


augroup UpdateCurrentDir
  autocmd!
  autocmd BufEnter * silent! !echo %:p:h > /tmp/vim_current_dir
augroup END


" Deleting temp file at the exit
autocmd VimLeave * silent! !rm /tmp/vim_current_dir


" Set auto current directory
set autochdir


" Define highlight group for search term
highlight SearchHighlight ctermfg=white ctermbg=red guifg=white guibg=red

" Custom search and replace function
function! CustomSearchReplace()
    " Prompt for search term
    let l:search = input('Enter search term: ')
    if empty(l:search)
        call clearmatches()
        echo "Search cancelled"
        return
    endif
    " Highlight all occurences of the search term
    try
        call matchadd('SearchHighlight', '\V' . escape(l:search, '\'))
        redraw
    catch
        echoerr "Error highlighting search term: " . v:exception
        call clearmatches()
        return
    endtry
    
    " Prompt for replace term
    let l:replace = input('Enter replace term: ')
    if empty(l:replace) && l:replace !=# '0'
        call clearmatches()
        echo "Replace cancelled"
        return
    endif
    
    " Perform the search and replace
    try
        execute '%s/' . escape(l:search, '\\/.*$^~[]') . '/' . escape(l:replace, '\\/.*$^~[]') . '/g'
"        echo "Replaced all occurrences of '" . l:search . "' with '" . l:replace . "'"
    catch
        echoerr "Error during replacement: " . v:exception
    endtry
"    call clearmatches()
endfunction

" Map <Space>s to the search and replace function in normal mode
nnoremap <Space>s :call CustomSearchReplace()<CR>


