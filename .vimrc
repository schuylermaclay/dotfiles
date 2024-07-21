
" TODO fix this
" set viminfo^=%

" set viminfo='50,<1000,s100,:0,n~/.vim/viminfo
let s:darwin = has('mac')
let mapleader="\<Space>"

set shell=/opt/homebrew/bin/bash


silent! if plug#begin('~/.vim/plugged')

  if s:darwin
    let g:plug_url_format = 'git@github.com:%s.git'
  else
    let $GIT_SSL_NO_VERIFY = 'true'
  endif

  call plug#begin('~/.vim/plugged')
  
  Plug '/opt/homebrew/opt/fzf'
  Plug 'w0rp/ale'
  Plug 'vim-scripts/fish.vim',   { 'for': 'fish' }
  Plug 'itchyny/lightline.vim'
  Plug 'tpope/vim-vinegar'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-rhubarb'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-obsession'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-commentary'
  Plug 'sheerun/vim-polyglot'
  Plug 'takac/vim-hardtime'
  Plug 'rakr/vim-one'
  Plug 'vim-jp/syntax-vim-ex'
  Plug 'pangloss/vim-javascript'
  Plug 'othree/jspc.vim'
  Plug 'kopischke/vim-fetch'
  Plug 'othree/javascript-libraries-syntax.vim'
  Plug 'junegunn/rainbow_parentheses.vim'
  Plug 'junegunn/goyo.vim'
  Plug 'honza/vim-snippets'
  Plug 'gregsexton/gitv'
  Plug 'gavocanov/vim-js-indent'
  " Plug 'sgur/vim-editorconfig'
  Plug 'airblade/vim-gitgutter'
  " Plug 'AndrewRadev/splitjoin.vim'
  " Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'thinca/vim-textobj-function-javascript'
  Plug 'kana/vim-textobj-user'
  Plug 'chriskempson/base16-vim'
  " Plug 'justinmk/vim-dirvish'
  " Plug 'junegunn/vim-peekaboo'
  Plug 'godlygeek/tabular'
  Plug 'ryanoasis/vim-devicons'
  Plug 'chriskempson/base16-vim'
  Plug 'daviesjamie/vim-base16-lightline'

  call plug#end()
endif



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 01. General                                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap H ^
nnoremap L $

autocmd FileType help wincmd L
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 02. Events                                                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" In Makefiles DO NOT use spaces instead of tabs
autocmd FileType make setlocal noexpandtab
" In Ruby files, use 2 spaces instead of 4 for tabs
autocmd FileType ruby setlocal sw=2 ts=2 sts=2

autocmd BufEnter * :syntax sync fromstart

" use emacs-style tab completion when selecting files, etc
" set wildmode=longest,list,full,full
" make tab completion for files/buffers act like bash
set wildmenu
set viminfo=%,'9999,s512,n~/.vim/viminfo " Restore buffer list, marks are remembered for 9999 files, registers up to 512Kb are remembered
set wildchar=<TAB> " Character for CLI expansion (TAB-completion)
set wildignore+=.DS_Store
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/bower_components/*,*/node_modules/*
set wildignore+=*/smarty/*,*/vendor/*,*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/ckeditor/*,*/doc/*,*/source_maps/*,*/dist/*
set wildmode=list:longest " Complete only until point of ambiguity

let vimDir = '$HOME/.vim'

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif

" set swap dirs
set backupdir=~/.vim/tmp//
set directory=~/.vim/swp//


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 03. Theme/Colors                                                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable             " enable syntax highlighting (previously syntax on).

" gui colors if running iTerm
set termguicolors

set path+=**
 

set grepprg=rg\ --vimgrep\ $*
set gfm=%f:%l:%c:%m,%f:%l%m,%f\ \ %l%m
" let g:loaded_netrwPlugin = 1 " Disable netrw
" let g:loaded_netrw            = 1 " Disable netrw
" let g:vimfiler_as_default_explorer = 1
" set timeoutlen=1000 ttimeoutlen=0
set notimeout ttimeout
" nnoremap <leader>ft :VimFilerExplorer -toggle<cr>
" keep window keymaps in vimfiler
" autocmd FileType vimfiler nunmap <buffer> <C-l>
" autocmd FileType vimfiler nmap <buffer> <C-R>  <Plug>(vimfiler_redraw_screen)

" Search and replace word under cursor (leader*) {{{
nnoremap <leader>* :%s/\<<C-r><C-w>\>//<Left>
vnoremap <leader>* "hy:%s/\V<C-r>h//<left>
" }}}

" surround c wraps in js block comment
let g:surround_99 = "/*\r*/"

nnoremap <leader>sl :set list!<CR>
set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▹\ 
nnoremap <leader>sw :StripWhitespace<CR>


let g:lightline = {
  \   'colorscheme': 'base16',
  \   'active': {
  \     'left':[ [ 'mode', 'paste' ],
  \              [ 'gitbranch', 'readonly', 'filename', 'modified' ]
  \     ]
  \   },
	\   'component': {
	\     'lineinfo': ' %3l:%-2v',
	\   },
  \   'component_function': {
  \     'gitbranch': 'fugitive#head',
  \   'filetype': 'MyFiletype',
  \   'fileformat': 'MyFileformat',
  \   }
  \ }
let g:lightline.separator = {
	\   'left': '', 'right': ''
  \}
let g:lightline.subseparator = {
	\   'left': '', 'right': '' 
  \}

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 04. Vim UI                                                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number                " show line numbers
" set numberwidth=3         " make the number gutter 6 characters wide
set cul                   " highlight current line
set laststatus=2          " last window always has a statusline
set nohlsearch            " Don't continue to highlight searched phrases.
set incsearch             " But do highlight as you type your search.
set ignorecase            " Make searches case-insensitive.
set ruler                 " Always show info along bottom.
set showmatch
set visualbell
set mouse=a
set noshowmode
set backspace=indent,eol,start
set scrolloff=20
set hidden
set shortmess=aIT
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 05. Text Formatting/Layout                                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=2             " tab spacing
set softtabstop=2         " unify
set shiftwidth=2          " indent/outdent by 2 columns
set shiftround            " always indent/outdent to the nearest tabstop
set noexpandtab             " use spaces instead of tabs
" set smartindent           " automatically insert one extra level of indentation
set autoindent           " automatically insert one extra level of indentation
set smarttab              " use tabs at the start of a line, spaces elsewhere
set nowrap                " don't wrap text
set showtabline=0
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 06. Custom Commands                                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set lazyredraw
set encoding=utf8

set foldmethod=syntax
set foldlevelstart=1

set autoread
inoremap jk <ESC>

" skinny cursor for insert
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" FZF setup
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

nnoremap <leader>t :Files<cr>
nnoremap <leader>f :Find<cr>

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0) 


augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END 



noremap <C-p> :<Up>
noremap <M-w> <C-w>

noremap <C-j> <C-w>j
noremap <C-h> <C-w>h
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
" system clipboard shorcuts
vnoremap <Leader>y "*y
vnoremap <Leader>d "*d
nnoremap <Leader>p "*p
nnoremap <Leader>P "*P
"  map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>

nnoremap <leader>i :set incsearch!<CR>
nnoremap <leader>h :set hlsearch!<CR>


nnoremap <leader>sjs :SplitjoinSplit<CR>
nnoremap <leader>sjj :SplitjoinJoin<CR>

" List contents of all registers (that typically contain pasteable text).
nnoremap <silent> "" :registers "0123456789abcdefghijklmnopqrstuvwxyz*+:.<CR>

" Ale
let g:ale_linters = {
\   'javascript': ['eslint'],
\}

let g:fml_all_sources = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 1
let g:ale_lint_on_enter = 1

function! s:profile(bang)
  if a:bang
    profile pause
    noautocmd qall
  else
    profile start /tmp/profile.log
    profile func *
    profile file *
  endif
endfunction
command! -bang Profile call s:profile(<bang>0)


nnoremap <leader>o :only <cr>
nnoremap <leader>q :q <cr>

autocmd BufEnter,BufRead,BufNewFile *.md set filetype=markdown

":w with leader
nnoremap <leader>w :w <cr>
nnoremap <leader>bd :bd <cr>
nnoremap <leader>up :PU <cr>

nnoremap <leader>es :vsplit ~/Documents/scratch/scratchpad.txt<cr>

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
noremap <leader>sv :source $MYVIMRC<cr>
" nnoremap <leader>sv :source $MYVIMRC<cr>:AirlineRefresh<cr>
"vimplug update Command
command! PU PlugUpdate | PlugUpgrade


let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 1
" Write this in your vimrc file
" You can disable this option too
let g:ale_lint_on_enter = 0
" if you don't want linters to run on opening a file
let g:ale_sign_error ='⨉'
let g:ale_sign_warning ='⚠'

highlight clear ALEErrorSign
highlight clear ALEWarningSign

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif


autocmd BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\   exe "normal! g`\"" |
			\ endif


let base16colorspace=256

" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

vnoremap ; :
vnoremap ;; ;

colorscheme base16-monokai
