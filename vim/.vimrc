set nocompatible			   " be iMproved
filetype off				   " required!

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
"Plug 'tpope/vim-vinegar'
Plug 'majutsushi/tagbar'
Plug 'ap/vim-buftabline'
Plug 'rip-rip/clang_complete'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'Townk/vim-autoclose'
Plug 'qpkorr/vim-bufkill'
Plug 'fatih/vim-go'
Plug 'itchyny/lightline.vim'
Plug 'neomake/neomake'
Plug 'pearofducks/ansible-vim'
Plug 'lepture/vim-jinja'
Plug 'davidhalter/jedi-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-obsession'
Plug 'skywind3000/asyncrun.vim'

Plug 'mbbill/undotree'

Plug 'ryanoasis/vim-devicons'

Plug 'mhinz/vim-startify'
Plug 'danielbmarques/vim-ditto'

"For Fun
Plug 'ryanss/vim-hackernews'

call plug#end()

filetype plugin indent on	  " required!
"set encoding=utf-8
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

" *** Spelling Settings *** "
set spl=en_gb

set smartindent
set noexpandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=100
set mousehide " Hide the mouse cursor while typing
set history=1000 " Store a ton of history
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
set hlsearch
set showcmd
set backspace=2 "more powerful backspacing
set diffopt+=iwhite
set clipboard=unnamed
set timeoutlen=30  "Fix for the lightline lag on ESC !!

" ** Setting Leader Key** "
let mapleader=","

" *** Folding settings *** "
set foldmethod=indent	"fold based on indent
set foldnestmax=10		"deepest fold is 10 levels
set nofoldenable		"dont fold by default
set foldlevel=1			"this is just what i use


" Windows navigation "
nmap <C-Down> :wincmd j<CR>
nmap <C-Left> :wincmd h<CR>
nmap <C-Right> :wincmd l<CR>
nmap <C-Up> :wincmd k<CR>

" *** Directory configuration *** "
silent ! mkdir -p ~/tmp/
set dir=~/tmp/
set viminfo+=n~/tmp/viminfo

"CTRL-C => Copy
vnoremap <C-C> "+y
"CTRL-V => Paste
vnoremap <C-V> "+gP
"CTRL-X => Cut
vnoremap <C-X> "+x

"Disabling unused keys
"noremap"<Up> <Nop>
"noremap"<Down> <Nop>
"noremap"<Left> <Nop>
"noremap"<Right> <Nop>
noremap <F1> <Nop>

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
map J 10j
map H ^
map L $



"Neomake conf

autocmd! BufEnter,BufWritePost * Neomake

let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_python_flake8_maker = { 'args': ['--ignore=E701,W191,E303,E302,E711, \
			\ W191,F401,E128,E501,E502,E115,E265,W293'], }


let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 1
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#use_splits_not_buffers = "left"
let g:jedi#popup_on_dot = 1
let g:jedi#popup_select_first = 1
let g:jedi#auto_vim_configuration = 0
let g:jedi#show_call_signatures = 2
let g:jedi#completions_enabled = 1

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
	   \			 [ 'filename', 'readonly', 'modified' ],
	   \			 [ 'fugitive', 'async' ] ]
	   \ },
	   \ 'component': {
	   \   'readonly': '%{&filetype=="help"?"":&readonly?"x":""}',
	   \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
	   \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}',
	   \   'async'	 : '%{g:asyncrun_status=="running"?"ASYNC":""}'
	   \ },
	   \ 'component_visible_condition': {
	   \   'readonly': '(&filetype!="help"&& &readonly)',
	   \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
	   \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())',
	   \   'async'	 : '(g:asyncrun_status=="running")'
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
autocmd FileType python set noet ts=4 | %retab!
" autocmd FileType python setlocal completeopt-=preview
" autocmd FileType cpp set omnifunc=ccomplete#Complete

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
set guifont=Droid\ Sans\ Mono\ Slashed\ for\ Powerline\ 11
set guioptions-=m "remove menu bar
set guioptions-=T "remove toolbar"
set guioptions-=r  "scrollbar"

set clipboard=unnamed
