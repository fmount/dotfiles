set nocompatible               " be iMproved
filetype off                   " required!

" Vim-plug auto download
if empty(glob('~/.vim/autoload/plug.vim'))
silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"---------------------:

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'
Plug 'ap/vim-buftabline'
"Plug 'rip-rip/clang_complete'
"Plug 'tpope/vim-vinegar'
"Plug 'Townk/vim-autoclose'
"Plug 'davidhalter/jedi-vim'
"Plug 'ludovicchabant/vim-gutentags'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'qpkorr/vim-bufkill'
Plug 'fatih/vim-go'
Plug 'itchyny/lightline.vim'
Plug 'neomake/neomake'
Plug 'pearofducks/ansible-vim'
Plug 'lepture/vim-jinja'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-obsession'
Plug 'skywind3000/asyncrun.vim'
Plug 'Valloric/YoucompleteMe'
Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons'

"Write better
Plug 'danielbmarques/vim-ditto'
Plug 'junegunn/goyo.vim'
Plug 'mbbill/undotree'

"For Fun
Plug 'dansomething/vim-hackernews'

Plug 'fmount/vim-notes'

"DEV
"Plug 'fmount/vim-notes'
call plug#end()

filetype plugin indent on    " required!
"set encoding=utf-8
set fileencoding=utf-8
syntax on
set wrap
set number
colorscheme jellybeans
set shortmess+=IA
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
"let mapleader=" "

" *** Folding settings *** "
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use


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

" *** ESC like a boss ***
"#noremap jj <Esc>
inoremap jj <Esc>
"#cnoremap jj <Esc>
"map jj <Esc>

" *** Buffer2Tab Config and navigation *** "
set hidden
nnoremap <C-N> :bnext!<CR>
nnoremap <C-P> :bprevious!<CR>
let g:buftabline_indicators=1
let g:buftabline_numbers=1
let g:buftabline_separators=1


" *** Some mappings *** "
nmap <F2> :TagbarToggle<CR>
nmap <F3> :NERDTreeToggle<CR>
nnoremap <F4> <Esc>:set spell!<CR><Bar>:echo "Spell Check: " . strpart("OffOn", 3 * &spell, 3)<CR>
inoremap <F4> <Esc>:set spell!<CR><Bar>:echo "Spell Check: " . strpart("OffOn", 3 * &spell, 3)<CR>i
nnoremap <F5> <Esc>:redraw!<CR>
inoremap <F5> <Esc>:redraw!<CR>
nmap <F6> :UndotreeToggle<CR>

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



"Neomake conf

autocmd! BufEnter,BufWritePost * Neomake

let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_python_flake8_maker = { 'args': ['--ignore=E701,W191,E303,E302,E711, \
            \ W191,F401,E128,E501,E502,E115,E265,W293'], }


" YouCompleteMe conf
let g:ycm_always_populate_location_list = 0

"CtRLp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

"Make Ctrl-P cache stuff in our temp directory.
let g:ctrlp_cache_dir = expand("<sfile>:h").'/cache'
" Remember things.
let g:ctrlp_clear_cache_on_ext = 0
 "Enable some cool extensions.
let g:ctrlp_extensions = [
         \'tag', 'buffertag', 'quickfix', 'mixed', 'bookmarkdir',
         \'autoignore' ]


" Ctrl-P mappings.
nnoremap <silent> <C-p> :CtrlPMixed<cr>
nnoremap <silent> <C-o> :CtrlPBuffer<cr>
nnoremap <silent> <C-u> :CtrlPTag<cr>
nnoremap <silent> <C-y> :CtrlPQuickfix<cr>
"nnoremap <silent> <Tab> :CtrlPMRUFiles<cr>
"nnoremap <silent> <F8> :CtrlPBookmarkDir<cr>


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
       \   'async'   : '%{g:asyncrun_status=="running"?"ASYNC":""}'
       \ },
       \ 'component_visible_condition': {
       \   'readonly': '(&filetype!="help"&& &readonly)',
       \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
       \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())',
       \   'async'   : '(g:asyncrun_status=="running")'
       \ },
\ }


" *** nerdTree GIT Plugin *** "

let g:NERDTreeIndicatorMapCustom = {
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


" *** Mark plugin configuration ***
let g:mwDefaultHighlightingPalette = 'extended'
nmap <C-A-F12>a <Plug>MarkSearchCurrentPrev
nmap <C-A-F12>b <Plug>MarkSearchAnyNext
nmap <C-A-F12>c <Plug>MarkRegex
nmap <C-A-F12>d <Plug>MarkClear
nmap <C-A-F12>e <Plug>MarkSearchCurrentNext
nmap <C-A-F12>f <Plug>MarkSearchAnyPrev


" *** FILE TYPES SETTINGS ***

" *** MARKDOWN ***
autocmd FileType markdown setlocal expandtab
let g:markdown_fenced_languages = ['c', 'bash=sh']
let g:markdown_syntax_conceal = 0
au FileType markdown,text,tex DittoOn  " Turn on Ditto's autocmds

" *** PYTHON *** "
autocmd FileType python set et ts=4 | %retab!
" autocmd FileType python setlocal completeopt-=preview
" autocmd FileType cpp set omnifunc=ccomplete#Complete

" *** GO *** "
"augroup GO
"  autocmd FileType go set foldmethod=syntax
"  autocmd BufEnter *.go :normal za<CR>
"augroup END

" *** YAML *** "
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yml setlocal ts=2 sts=2 sw=2 expandtab
autocmd BufEnter * silent! lcd %:p:h

" *** VIM FILES ***
autocmd FileType vim setlocal fileformat=unix
autocmd FileType vim setlocal expandtab

" *** Set cursor color ***
highlight Cursor guifg=white guibg=#BC6A00

" *** Load templates according to filetype *** "
autocmd BufNewFile *.py 0r /usr/share/vim/vimfiles/python.spec
autocmd BufNewFile *.sh 0r /usr/share/vim/vimfiles/bash.spec
"

"[GVIM]Try to write something about gui
set guifont=Share\ Tech\ Mono\ 12
set guioptions-=m "remove menu bar
set guioptions-=T "remove toolbar"
set guioptions-=r  "scrollbar"

set clipboard=unnamed


" VIM-NOTES overrides "
"
let g:default_keymap = 0
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
