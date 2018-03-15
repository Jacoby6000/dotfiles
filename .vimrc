let mapleader = "\<SPACE>"

if &compatible
  set nocompatible
endif

if has('nvim')
  call plug#begin('~/.config/nvim/plugged')
  execute pathogen#infect('~/.config/nvim/unmanaged/{}')
  Plug 'Shougo/deoplete.nvim'
else
  call plug#begin('~/.vim/plugged')
  execute pathogen#infect('~/.vim/unmanaged/{}')
  Plug 'Valloric/YouCompleteMe'
endif

Plug 'rking/ag.vim'
Plug 'robu3/vimongous'
Plug 'sirtaj/vim-openscad'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'bling/vim-airline'
Plug 'majutsushi/tagbar'
Plug 'flazz/vim-colorschemes'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'derekwyatt/vim-scala'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'mileszs/ack.vim'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-markdown'
Plug 'geverding/vim-hocon'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-surround'
Plug 'rking/ag.vim'
Plug 'Yggdroot/indentLine'
Plug 'in3d/vim-raml'
Plug 'elzr/vim-json'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'jaxbot/syntastic-react'
Plug 'vim-scripts/greplace.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'carlitux/deoplete-ternjs'
Plug 'ternjs/tern_for_vim'
Plug 'gregsexton/matchtag'
Plug 'ntpeters/vim-better-whitespace'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'eagletmt/ghcmod-vim'
Plug 'eagletmt/neco-ghc'
Plug 'neovimhaskell/haskell-vim'
Plug 'ensime/ensime-vim'
Plug 'scrooloose/vim-slumlord'
Plug 'aklt/plantuml-syntax'
Plug 'uarun/vim-protobuf'
Plug 'xolox/vim-misc'
Plug 'AndrewRadev/sideways.vim'
Plug 'sbdchd/neoformat'
Plug 'numkil/ag.nvim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()


filetype plugin on

colorscheme molokai

autocmd BufNewFile,BufRead *.json?*  setfiletype json

autocmd BufNewFile,BufRead *.scala   setfiletype scala
autocmd BufNewFile,BufRead *.sc      setfiletype scala
autocmd BufNewFile,BufRead *.ws      setfiletype scala

autocmd BufNewFile,BufRead *.simba   setfiletype pascal

autocmd BufNewFile,BufRead *.hs setfiletype haskell

set ts=2
set sts=2
set expandtab  " Convert tabs to spaces
set nu
set nohlsearch
set cursorline " Highlight current line
set foldlevelstart=20
set foldmethod=syntax
set colorcolumn=120

set statusline=%t "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'},\  "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h "help file flag
set statusline+=%m "modified flag
set statusline+=%r "read only flag
set statusline+=%y "filetype
set statusline+=%= "left/right separator
set statusline+=%c: "cursor column
set statusline+=%l/%L "cursor line/total lines
set statusline+=\ %P "percent through file
set laststatus=2

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
set wildignore+=tags
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*
set wildignore+=*.class,*.jar,*.iml,*.classpath,*/target/*

let g:airline_powerline_fonts = 1            " Use powerline fonts with airline. may need to switch terminal font to a powerline font. I use sourcecodepro powerline enabled
let g:airline#extensions#tabline#enabled = 1

let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 100
let g:deoplete#disable_auto_complete = 0

let g:UltiSnipsExpandTrigger="<c-s><c-t>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="vertical"

inoremap <silent><expr> <C-SPACE>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ deoplete#mappings#manual_complete()

function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

let g:ag_working_path_mode="r"

let g:indentLine_char = '│'

let g:scala_sort_across_groups=1

" Useful keymaps
noremap  <leader>n :NERDTreeToggle<CR>   " space+n to open/close file tree
noremap  <leader>t :TagbarToggle<CR>   " space+t to open/close tag bar

" Replace word under wursor with text in clipboard
noremap  <leader>rwc viw"+p
nnoremap <C-p> :FZF<cr>
nnoremap <C-P> :FZF!<cr>

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nnoremap <leader>T :enew<cr>

" Move to the next buffer
nnoremap <leader>ll :bnext<CR>

" Move to the previous buffer
nnoremap <leader>hh :bprevious<CR>

" move parameter left
nnoremap <leader>h :SidewaysLeft<cr>

" move parameter right
nnoremap <leader>l :SidewaysRight<cr>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nnoremap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nnoremap <leader>bl :ls<CR>

nnoremap <Leader>w :w<CR>

nnoremap <leader>q @q

nnoremap <silent><leader>/ :nohl<CR>

" Disable Arrow keys so you plebs stay on the home-row.
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

nnoremap <silent><space>gb :Gblame<CR>
nnoremap <silent><space>gs :Gstatus<CR>
nnoremap <silent><space>gp :Gpush<CR>
nnoremap <silent><space>gr :Gpull --rebase<CR>


noremap ; :
" noremap : ;

nnoremap <silent><leader>fw :Ag <cword><CR>

" Nerd-tree configuration
autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Allow project-specific vimrc
set exrc
" ...and be secure!
set secure

function! SQualifiedTagJump() abort
  let l:plain_tag = expand("<cword>")
  let l:orig_keyword = &iskeyword
  set iskeyword+=\.
  let l:word = expand("<cword>")
  let &iskeyword = l:orig_keyword

  let l:splitted = split(l:word, '\.')
  let l:acc = []
  for wo in l:splitted
    let l:acc = add(l:acc, wo)
    if wo ==# l:plain_tag
      break
    endif
  endfor

  let l:combined = join(l:acc, ".")
  try
    execute "ta " . l:combined
  catch /.*E426.*/ " Tag not found
    execute "ta " . l:plain_tag
  endtry
endfunction

