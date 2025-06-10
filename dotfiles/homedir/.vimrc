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






" Highlighint all leading Tabs
highlight Tab ctermbg=LightBlue guibg=LightBlue
autocmd BufEnter * call matchadd('Tab', '^\t\+', -1)
autocmd BufLeave * call clearmatches()

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
