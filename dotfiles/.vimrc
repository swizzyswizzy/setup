call plug#begin()

Plug 'mbbill/undotree'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()








nnoremap <SPACE> <Nop>
let mapleader=" "

map <Leader>a ggVG
nnoremap <Leader>u :UndotreeToggle<CR>
nnoremap <leader>pv :Ex<CR>
nnoremap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>




" turn hybrid line numbers on
:set number relativenumber
:set nu rnu


syntax enable
set background=dark
colorscheme solarized
