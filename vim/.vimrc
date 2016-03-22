set nocompatible               " be iMproved
filetype off                   " required!

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'ap/vim-buftabline'
Plug 'rip-rip/clang_complete'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

filetype plugin indent on     " required!

"source ~/.vim/.vimrc_mdlive_module
"source ~/.vim/.vimrc_texlive

"set encoding=utf-8
set fileencoding=utf-8
syntax on
set wrap
set number
colorscheme desertEx
"colorscheme jellybeans
set shortmess+=IA
set selectmode=mouse
set ignorecase
set smartcase
set wrapscan
set spl=en_gb
set smartindent
set noexpandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=100
set mousehide " Hide the mouse cursor while typing
set history=1000 " Store a ton of history (default is 20)
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
set hlsearch
set showcmd
set backspace=2 "more powerful backspacing
set diffopt+=iwhite
set clipboard=unnamed

" Windows navigation "
nmap <C-Down> :wincmd j<CR>
nmap <C-Left> :wincmd h<CR>
nmap <C-Right> :wincmd l<CR>
nmap <C-Up> :wincmd k<CR>
"CTRL-C => Copy
vnoremap <C-C> "+y
"CTRL-V => Paste
vnoremap <C-V> "+gP
"CTRL-X => Cut
vnoremap <C-X> "+x
"Disabling arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

""Buffer2Tab Config 
set hidden
nnoremap <C-N> :bnext!<CR>
nnoremap <C-P> :bprevious!<CR>
let g:buftabline_indicators=1
let g:buftabline_numbers=1


nmap <F2> :TagbarToggle<CR>
nmap <F3> :NERDTreeToggle<CR>
nnoremap <F4> <Esc>:set spell!<CR><Bar>:echo "Spell Check: " . strpart("OffOn", 3 * &spell, 3)<CR>
inoremap <F4> <Esc>:set spell!<CR><Bar>:echo "Spell Check: " . strpart("OffOn", 3 * &spell, 3)<CR>i


autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python set noet ts=4 | %retab!
autocmd FileType cpp set omnifunc=ccomplete#Complete

let g:airline_powerline_fonts=0
"set second section to filename
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_section_b="%f"
" empty third and fourth sections
let g:airline_section_c=""
let g:airline_section_x=""
"let g:airline_section_error=""
let g:airline_section_warning=""
" put filetype in fifth section
let g:airline_section_y="%y"
let g:airline_theme='simple'
