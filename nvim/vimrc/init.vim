set nocompatible               " be iMproved
filetype off                   " required!

set path+=**

" Vim-plug auto download
if empty(glob('~/.config/nvim/autoload/plug.vim'))
silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"---------------------:

" Set colorscheme
if empty(glob('~/.config/nvim/colors/jellybeans.vim'))
silent !curl -fLo ~/.config/nvim/colors/jellybeans.vim --create-dirs
\ https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim
endif
"---------------------:

call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-buftabline'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'qpkorr/vim-bufkill'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-obsession'
Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'liuchengxu/vista.vim'
Plug 'junegunn/gv.vim'

Plug 'mbbill/undotree'
Plug 'equalsraf/neovim-gui-shim'

"For Fun
Plug 'fmount/vim-notes'
Plug 'junegunn/goyo.vim'

" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'simrat39/symbols-outline.nvim'

" Completion framework
Plug 'hrsh7th/nvim-cmp'

" LSP completion source for nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'

" Snippet completion source for nvim-cmp
Plug 'hrsh7th/cmp-vsnip'

" Other usefull completion sources
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'

" To enable more of the features of rust-analyzer, such as inlay hints and more!
Plug 'simrat39/rust-tools.nvim'

" Snippet engine
Plug 'hrsh7th/vim-vsnip'

" Fuzzy finder
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope-media-files.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope-project.nvim'

call plug#end()

lua require('lspconfig')

" cursor flickering issue
hi EndOfBuffer ctermbg=NONE ctermfg=200 cterm=NONE
hi Normal ctermbg=NONE ctermfg=200 cterm=NONE

filetype plugin indent on    " required!
syntax on
set wrap
set number
colorscheme jellybeans
set colorcolumn=80
set selectmode=mouse
set ignorecase
set smartcase
set wrapscan

" *** Spelling Settings *** "
set spl=en_gb

set smartindent
set expandtab
set tabstop=4
set softtabstop=4
set showtabline=2
set shiftwidth=4
set textwidth=0
set mousehide " Hide the mouse cursor while typing
set history=1000 " Store a ton of history
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
set hlsearch
set showcmd
set backspace=2 "more powerful backspacing
set diffopt+=iwhite
set clipboard=unnamed
"set timeoutlen=30  "Fix for the lightline lag on ESC !!

" ** Setting Leader Key** "
let mapleader=","

" *** Folding settings *** "
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Windows navigation "
nmap <C-Down> :wincmd j<CR>
nmap <C-Left> :wincmd h<CR>
nmap <C-Right> :wincmd l<CR>
nmap <C-Up> :wincmd k<CR>

" *** Directory configuration *** "
"silent ! mkdir -p ~/tmp/
"set dir=~/tmp/
"set viminfo+=n~/tmp/viminfo

"CTRL-C => Copy
vnoremap <C-C> "+y
"CTRL-V => Paste
vnoremap <C-V> "+gP
"CTRL-X => Cut
vnoremap <C-X> "+x

"Disabling unused keys
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>
noremap <F1> <Nop>
noremap <C-F1> <Nop>

" *** ESC like a boss ***
"#noremap jj <Esc>
inoremap jj <Esc>
"#cnoremap jj <Esc>
"map jj <Esc>

" *** Buffer navigation *** "
set hidden
nnoremap <C-N> :bnext!<CR>
nnoremap <C-P> :bprevious!<CR>
let g:buftabline_indicators=1
let g:buftabline_numbers=1
let g:buftabline_separators=1


" *** Some mappings *** "
nmap <F2> :Vista!!<CR>
nmap <F3> :NERDTreeToggle<CR>
nnoremap <F4> <Esc>:set spell!<CR><Bar>:echo "Spell Check: " . strpart("OffOn", 3 * &spell, 3)<CR>
inoremap <F4> <Esc>:set spell!<CR><Bar>:echo "Spell Check: " . strpart("OffOn", 3 * &spell, 3)<CR>i
nnoremap <F5> <Esc>:redraw!<CR>
inoremap <F5> <Esc>:redraw!<CR>
nmap <F6> :UndotreeToggle<CR>
" *** don't mess w/ nerdtree window! ***
autocmd FileType nerdtree noremap <buffer> <C-N> <nop>
autocmd FileType nerdtree noremap <buffer> <C-P> <nop>

" *** Windows Resizing ***
nnoremap < :vertical resize +5<CR>
nnoremap > :vertical resize -5<CR> "

" *** Moving tricks ??? *** "
map <C-k> <PageUp>
map <C-j> <PageDown>
map K 10k
"map J 10j
map H ^
map L $


let g:gutentags_ctags_exclude = ['venv', 'build', 'static', 'node_modules']
let g:gutentags_cache_dir = expand("<sfile>:h").'/tags'
let g:gutentags_options_file = expand("<sfile>:h").'/ctagsrc'


" *** Configurations for ligthline ***

set laststatus=2
let g:lightline = {
       \ 'active': {
       \   'left': [ [ 'mode', 'paste' ],
       \             [ 'filename', 'readonly', 'modified' ],
       \             [ 'fugitive', 'async' ] ]
       \ },
       \ 'component': {
       \   'readonly': '%{&filetype=="help"?"":&readonly?"x":""}',
       \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
       \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}',
       \ },
       \ 'component_visible_condition': {
       \   'readonly': '(&filetype!="help"&& &readonly)',
       \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
       \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())',
       \ },
      \ 'component_function': {
      \   'method': 'NearestMethodOrFunction'
      \ },
\ }


" *** nerdTree GIT Plugin *** "

let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

" ** UndoTree conf ** "

if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif

" *** MARKDOWN ***
let g:markdown_fenced_languages = ['c', 'bash=sh']
let g:markdown_syntax_conceal = 0

" *** Set cursor color ***
highlight Cursor guifg=white guibg=#BC6A00

"[GVIM]Try to write something about gui
"set guifont=Share\ Tech\ Mono:h14
"set guifont=Spleen
set guioptions-=m "remove menu bar
set guioptions-=T "remove toolbar"
set guioptions-=r  "scrollbar"

set clipboard=unnamed

" VIM-NOTES overrides "
let g:default_keymap = 0
let g:notes_template_path = "$HOME/.config/nvim/plugged/vim-notes/templates/template.M"
nmap <Leader>ni (note-new-cbox-inline)
nmap <Leader>ni (note-new-cbox-inline)
imap <Leader>ni (note-new-cbox-inline)
nmap <Leader>no (note-new-cbox-below)
imap <Leader>no (note-new-cbox-below)
nmap <Leader>nO (note-new-cbox-above)
imap <Leader>nO (note-new-cbox-above)
nmap <Leader>nx :call notes#toggle_checkbox(line('.'))<cr>
" Fast Export function
nmap <leader>ne :call notes#export() <cr>


" treesitter
lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}
lua require('fmount.lsp')
lua require('fmount.telescope')
lua require('fmount.diagnostics')
lua require("fmount.term")

" *** GO indentation *** "
augroup GO
  autocmd FileType go set noexpandtab
  autocmd FileType go set shiftwidth=4
  autocmd FileType go set softtabstop=4
  autocmd FileType go set tabstop=4
augroup END

augroup FMOUNT
  autocmd FileType markdown setlocal expandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType yml setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType python set et ts=4 | %retab!
  autocmd BufEnter * silent! lcd %:p:h
  autocmd FileType vim setlocal fileformat=unix
  autocmd FileType vim setlocal expandtab
  autocmd BufEnter,BufWinEnter,TabEnter *.rs :compiler cargo
augroup END

let s:fontsize = 12
function! AdjustFontSize(amount)
  let s:fontsize = s:fontsize+a:amount
   :execute "GuiFont! Share\ Tech\ Mono:h" . s:fontsize
   ":execute "GuiFont! Spleen\ 32x64:h" . s:fontsize
endfunction

" Font resize
noremap <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>
noremap <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>
inoremap <C-ScrollWheelUp> <Esc>:call AdjustFontSize(1)<CR>a
inoremap <C-ScrollWheelDown> <Esc>:call AdjustFontSize(-1)<CR>a

"Child mode
set mouse=

