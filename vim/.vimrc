set nocompatible               " be iMproved
filetype off                   " required!

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
"Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'ap/vim-buftabline'
Plug 'rip-rip/clang_complete'
"Plug 'ekalinin/Dockerfile'

call plug#end()

filetype plugin indent on     " required!

"source ~/.vim/.vimrc_mdlive_module
source ~/.vim/.vimrc_texlive

" #### EDITOR CONF #### "
set encoding=utf-8
set fileencoding=utf-8
syntax on
set wrap
set number
"colorscheme desertEx
colorscheme jellybeans
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
  "set showtabline=2
set textwidth=80
"set shell=/bin/bash\ -i
set mousehide " Hide the mouse cursor while typing
set history=1000 " Store a ton of history (default is 20)
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
set hlsearch
set ruler " Show the ruler
	"set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
set rulerformat=%30(%=\:%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
set showcmd
set backspace=2 "more powerful backspacing
set diffopt+=iwhite
set clipboard=unnamed
"if !&diff|set shell=/bin/bash\ -i|endif
"set shellcmdflag=-ic
	"set mapleader="!"
"

"Live_md.py configs
"set backup
"set writebackup
"set backupcopy=yes

" Windows navigation "
nmap <C-Down> :wincmd j<CR>
nmap <C-Left> :wincmd h<CR>
nmap <C-Right> :wincmd l<CR>
nmap <C-Up> :wincmd k<CR>

"
"CTRL-C => Copy
vnoremap <C-C> "+y

"CTRL-V => Paste
vnoremap <C-V> "+gP
"
""CTRL-X => Cut
vnoremap <C-X> "+x

""Buffer2Tab Config 
set hidden
nnoremap <C-N> :bnext!<CR>
nnoremap <C-P> :bprevious!<CR>
"Close buffer => :bd (I always forget this command!![WTF])
" Indicators 
let g:buftabline_indicators=1
" Numbers
let g:buftabline_numbers=1


nmap <F2> :TagbarToggle<CR>
nmap <F3> :NERDTreeToggle<CR>

nnoremap <F6> <Esc>:set spell!<CR><Bar>:echo "Spell Check: " . strpart("OffOn", 3 * &spell, 3)<CR>
inoremap <F6> <Esc>:set spell!<CR><Bar>:echo "Spell Check: " . strpart("OffOn", 3 * &spell, 3)<CR>i

"imap <C-Right> "+w
"imap <C-Left> "+b
"inoremap <C-right> "+w
"inoremap <C-left> "+b

if &term =~ '^screen'
  " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python set noet ts=4 | %retab!
autocmd FileType cpp set omnifunc=ccomplete#Complete

