" iTerm colour support
set t_Co=256

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

Bundle 'wincent/Command-T'
Bundle 'ZoomWin'
Bundle 'kien/ctrlp.vim'
Bundle 'LustyJuggler'

" UI Additions
"Bundle 'mutewinter/vim-indent-guides'
Bundle 'Lokaltog/vim-powerline'
Bundle 'scrooloose/nerdtree'
"Bundle 'Rykka/colorv.vim'
"Bundle 'nanotech/jellybeans.vim'
"Bundle 'tomtom/quickfixsigns_vim'
" Commands
Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-surround'
"Bundle 'tpope/vim-speeddating'
Bundle 'tpope/vim-fugitive'
Bundle 'godlygeek/tabular'
Bundle 'mileszs/ack.vim'
Bundle 'copypath.vim'
"Bundle 'gmarik/sudo-gui.vim'
"Bundle 'milkypostman/vim-togglelist'
"Bundle 'mutewinter/swap-parameters'
"Bundle 'keepcase.vim'
"Bundle 'scratch.vim'
"Bundle 'mattn/zencoding-vim'
" Automatic Helpers
"Bundle 'IndexedSearch'
"Bundle 'xolox/vim-session'
"Bundle 'Raimondi/delimitMate'
"Bundle 'scrooloose/syntastic'
Bundle 'ervandew/supertab'
"Bundle 'gregsexton/MatchTag'
"Bundle 'Shougo/neocomplcache'
" Snippets
"Bundle 'garbas/vim-snipmate'
"Bundle 'honza/snipmate-snippets'
"Bundle 'MarcWeber/vim-addon-mw-utils'
" Language Additions
"   Ruby
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-rake'
" Rpsec
Bundle 'skalnik/vim-vroom'
"   JavaScript
Bundle 'pangloss/vim-javascript'
Bundle 'kchmck/vim-coffee-script'
Bundle 'leshill/vim-json'
Bundle 'itspriddle/vim-jquery'
"Bundle 'nono/vim-handlebars'
"   TomDoc
"Bundle 'mutewinter/tomdoc.vim'
"Bundle 'jc00ke/vim-tomdoc'
"   Other Languages
"Bundle 'msanders/cocoa.vim'
"Bundle 'mutewinter/taskpaper.vim'
"Bundle 'mutewinter/nginx.vim'
"Bundle 'timcharper/textile.vim'
"Bundle 'ChrisYip/Better-CSS-Syntax-for-Vim'
Bundle 'acustodioo/vim-tmux'
Bundle 'hallison/vim-markdown'
Bundle 'groenewege/vim-less'
" MatchIt
"Bundle 'matchit.zip'
"Bundle 'kana/vim-textobj-user'
"Bundle 'nelstrom/vim-textobj-rubyblock'
" Libraries
"Bundle 'L9'
"Bundle 'tpope/vim-repeat'
"Bundle 'tomtom/tlib_vim'
Bundle 'mathml.vim'
"Bundle 'gpg.vim'
Bundle 'jpalardy/vim-slime'

syntax on
set number
filetype plugin indent on

" This line MUST come before any <leader> mappings
let mapleader = ";"

" ---------------
" Backups
" ---------------
"set backup
"set backupdir=~/.vim/backup
"set directory=~/.vim/tmp
set noswapfile
set nobackup

" ---------------
" UI
" ---------------
set ruler          " Ruler on
set nu             " Line numbers on
set nowrap         " Line wrapping off
set laststatus=2   " Always show the statusline
set cmdheight=2    " Make the command area two lines high
set encoding=utf-8
if exists('+colorcolumn')
  set colorcolumn=80 " Color the 80th column differently
endif
" Disable tooltips for hovering keywords in Vim
if exists('+ballooneval')
  " This doesn't seem to stop tooltips for Ruby files
  set noballooneval
  " 100 second delay seems to be the only way to disable the tooltips
  set balloondelay=100000
endif

" ---------------
" Color
" ---------------
set background=dark
color molokai

" ---------------
" Behaviors
" ---------------
syntax enable
set autoread           " Automatically reload changes if detected
set wildmenu           " Turn on WiLd menu
set hidden             " Change buffer - without saving
set history=768        " Number of things to remember in history.
set cf                 " Enable error files & error jumping.
if $TMUX == ''
  set clipboard+=unnamed
endif
"set clipboard+=unnamed " Yanks go on clipboard instead.
set autowrite          " Writes on make/shell commands
set timeoutlen=350     " Time to wait for a command (after leader for example)
set foldlevelstart=99  " Remove folds
set formatoptions=crql
set iskeyword+=$,@     " Add extra characters that are valid parts of variables

" ---------------
" Text Format
" ---------------
set tabstop=2
set backspace=2  " Delete everything with backspace
set shiftwidth=2 " Tabs under smart indent
set cindent
set autoindent
set smarttab
set expandtab
set backspace=2

" ---------------
" Searching
" ---------------
set ignorecase " Case insensitive search
set smartcase  " Non-case sensitive search
set incsearch
set hlsearch
set wildignore+=*.o,*.obj,*.exe,*.so,*.dll,*.pyc,.svn,.hg,.bzr,.git,.sass-cache,*.class,*.scssc,target/**,vendor/bundle/**,vendor/ruby/**,coverage/**,tmp/**,reports/**,solr/**,**/bower_components/*,**/node_modules/*

" ---------------
" Visual
" ---------------
set showmatch   " Show matching brackets.
set matchtime=2 " How many tenths of a second to blink

" ---------------
" Sounds
" ---------------
set noerrorbells
set novisualbell
set t_vb=

" ---------------
" Mouse
" ---------------
set mousehide  " Hide mouse after chars typed
set mouse=a  " Mouse in all modes

" Better complete options to speed it up
set complete=.,w,b,u,U

" ----------------------------------------
" Bindings
" ----------------------------------------
" Fixes common typos
command! W w
command! Q q
map <F1> <Esc>
imap <F1> <Esc>


" Disable the ever-annoying Ex mode shortcut key. Type visual my ass.
nmap Q <nop>

"set formatoptions=croqln
"set formatoptions=croqln
"set tabstop=2
"set expandtab
"set cursorline
"set softtabstop=2
"set shiftwidth=2
"set ignorecase
"set smartcase
"set incsearch
"set scrolloff=3
"set sidescrolloff=5
"set wildmode=longest,list
"set nocompatible
"set autoindent
"set smartindent
"set mouse=a
"set modelines=0
" allow status-bar windows (0-height)
"set wmh=0
" set iskeyword-=_ \" allow underscore to delimit words"
"set backupdir=/tmp
"set directory=/tmp
"set showcmd
"set cursorline
"set ruler
"set backspace=indent,eol,start
"set laststatus=2
"set showmode!

" Command-T
let g:CommandTMatchWindowAtTop=1 " show window at top
let g:CommandTMaxFiles=20000
nmap <leader>t :CommandT<cr>
nmap <leader>k :CommandTBuffer<cr>

" Lusty Juggler
nmap <leader>b :LustyJuggler<cr>

"set relativenumber
"set undofile

" Running tests
nmap <leader>s :VroomRunTestFile<cr>
nmap <leader>S :VroomRunNearestTest<cr>

"
"
set tags+=.git/tags

"let g:autotagTagsFile="TAGS"

"draw tabs & trailing spaces
autocmd BufNewFile,BufRead * set list listchars=tab:▸\
set list listchars=tab:\ \ ,trail:·

autocmd BufNewFile,BufRead * match Error /\(  \+\t\@=\)\|\(^\(\t\+\)\zs \ze[^ *]\)\|\([^ \t]\zs\s\+$\)/
                             match Error /\(  \+\t\@=\)\|\(^\(\t\+\)\zs \ze[^ *]\)\|\([^ \t]\zs\s\+$\)/

" open NERDTree in every tab
" autocmd VimEnter * NERDTree
" autocmd BufEnter * NERDTreeMirror
autocmd VimEnter * wincmd p

"autocmd BufNewFile,BufRead *.json set ft=javascript
"autocmd BufNewFile,BufRead *.template set ft=javascript
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" save file on lose of focus
autocmd FocusLost * :wa

" Remove trailing whitespace
autocmd FocusLost,BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

:tabnext


"" tab left & right
" same for macvim (cmd key, because alt doesn't work)
""NOTE: only run this on macvim - on gnome, it causes an ambiguous map for "<<" (unindent line)
map <D-j> gt
map <D-k> gT

"let Tlist_WinWidth = 50 map <F4> :TlistToggle<cr>

" leader-e for showing nerd-tree
map <leader>e :NERDTreeToggle<cr>
map <leader>r :NERDTreeFind<cr>


"nmap <leader>b :FuzzyFinderBuffer<cr>
"nmap <leader>f :FuzzyFinderFileWithFullCwd<cr>
"nmap <leader>F :FuzzyFinderTaggedFile<cr>
"nmap <leader>g :FuzzyFinderTag<cr>

" Finder - options include  CTRL-P and CommandT
" nmap <leader>t <C-p>

" Ack
nnoremap <leader>a :Ack

" HTML ft mapped to a “fold tag” function:
nnoremap <leader>ft Vatzf

" Re-hardwrap paragraphs of text:
nnoremap <leader>q gqip

" Reselect text just pasted
nnoremap <leader>v V`]

" open up my ~/.vimrc file in a vertically
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

"If I really want a horizontal split I can use <C-w>s to get one
nnoremap <leader>w <C-w>v<C-w>l
" split windoesa
" This next set of mappings maps <C-[h/j/k/l]> to the commands needed to move around your splits. If you remap your capslock key to Ctrl it makes for very easy navigation.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Nerd Commenter - toggle comment
"nnoremap <leader>c<space>

" Ruby stuff
" help ft-ruby-syntax
let ruby_space_errors =1

" find usages
nmap <a-F7> :Ack -w <c-r><c-w><cr>

" show tags for current file
" nnoremap <leader>Q :TlistToggle<CR>
" let Tlist_Exit_OnlyWindow = 1     " exit if taglist is last window open
" let Tlist_Show_One_File = 1       " Only show tags for current buffer
" let Tlist_Enable_Fold_Column = 0  " no fold column (only showing one file)

" Bubble lines
nmap <C-Up> [e
nmap <C-Down> ]e

" Use _ as a word-separator
" set iskeyword-=_

" Highlight the status line
highlight StatusLine ctermfg=blue ctermbg=yellow

" Copy path - handy for pasting the filename in the terminal for running rspec
nmap <leader>cp :CopyPath<cr>

vmap <leader>bd "td?describe<CR>obefore do<CR>end<CR><ESC>kk"tp

" Custom Menlo font for Powerline
" From: https://github.com/Lokaltog/vim-powerline/wiki/Patched-fonts
set guifont=Menlo\ for\ Powerline:h12

imap jj <Esc>

" Auto resize the active window
"function! AutoResize()
"  let w = &columns*55/100
"  exec 'vertical resize '.w
"endfunction
"autocmd WinEnter * call AutoResize()

" relative line numbers
" http://jeffkreeftmeijer.com/2012/relative-line-numbers-in-vim-for-super-fast-movement/
"
"function! NumberToggle()
  "if(&relativenumber == 1)
    "set number
  "else
    "set relativenumber
  "endif
"endfunc

"nnoremap <C-n> :call NumberToggle()<cr>
":au FocusLost * :set number
":au FocusGained * :set relativenumber
"autocmd InsertEnter * :set number
"autocmd InsertLeave * :set relativenumber
"

command GdiffInTab tabedit %|Gdiff

" vim-slim
let g:slime_target = "tmux"


let g:JavaImpPaths = "/Users/stephen/work/dius/oua-workflow/src/main/java"
let g:JavaImpDataDir = "/Users/stephen/tmp"
