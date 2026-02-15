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

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'ap/vim-buftabline'
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'mhinz/vim-startify'
Plug 'liuchengxu/vista.vim'
Plug 'mbbill/undotree'

"Writing and take notes
Plug 'fmount/vim-notes'
Plug 'junegunn/goyo.vim'
Plug 'OXY2DEV/markview.nvim'

" Collection of common configurations for the Nvim LSP client
Plug 'equalsraf/neovim-gui-shim'
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
" Completion framework
Plug 'hrsh7th/nvim-cmp'
" LSP completion source for nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'
" Snippet completion source for nvim-cmp
Plug 'hrsh7th/cmp-vsnip'
" Other usefull completion sources
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
"
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

" Claude Code experiments
Plug 'greggh/claude-code.nvim'

call plug#end()

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
set spl=en_gb

set smartindent
set expandtab
set tabstop=4
set softtabstop=4
set showtabline=2
set shiftwidth=4
set textwidth=0
set mousehide " Hide the mouse cursor while typing
set history=1000 " Store history
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
set hlsearch
set showcmd
set backspace=2 "more powerful backspacing
set diffopt+=iwhite
set clipboard=unnamed

" ** Setting Leader Key** "
let mapleader=","

" *** Folding settings *** "
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

" Set completeopt to have a better completion experience
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

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

set guioptions-=m "remove menu bar
set guioptions-=T "remove toolbar"
set guioptions-=r  "scrollbar"

set clipboard=unnamed

lua require('fmount.lsp')
lua require('fmount.keymaps')
lua require('fmount.treesitter')
lua require('fmount.telescope')
lua require('fmount.diagnostics')
lua require("fmount.term")
lua require('fmount.claude')

" *** GO indentation *** "
augroup GO
  autocmd FileType go set noexpandtab
  autocmd FileType go set shiftwidth=4
  autocmd FileType go set softtabstop=4
  autocmd FileType go set tabstop=4
augroup END

augroup DEFAULT
  autocmd FileType markdown setlocal expandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType yml setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType python set et ts=4 | %retab!
  autocmd BufEnter * silent! lcd %:p:h
  autocmd FileType vim setlocal fileformat=unix
  autocmd FileType vim setlocal expandtab
  autocmd BufEnter,BufWinEnter,TabEnter *.rs :compiler cargo
augroup END


" KEYS REMAPPING
"
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

" *** ESC with jj ***
"#noremap jj <Esc>
inoremap jj <Esc>
"#cnoremap jj <Esc>
"map jj <Esc>

" *** Buffer navigation *** "
set hidden
nnoremap <C-N> :bnext!<CR>
nnoremap <C-P> :bprevious!<CR>

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

" *** other moving tricks *** "
map <C-k> <PageUp>
map <C-j> <PageDown>
map K 10k
"map J 10j
map H ^
map L $

let s:fontsize = 12
function! AdjustFontSize(amount)
  let s:fontsize = s:fontsize+a:amount
   :execute "GuiFont! NeoSpleen:h" . s:fontsize
endfunction

" Font resize
noremap <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>
noremap <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>
inoremap <C-ScrollWheelUp> <Esc>:call AdjustFontSize(1)<CR>a
inoremap <C-ScrollWheelDown> <Esc>:call AdjustFontSize(-1)<CR>a

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

"Child mode
set mouse=
