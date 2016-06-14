let mapleader = "\<SPACE>"

if &compatible
  set nocompatible
endif


if has('nvim')
  call plug#begin('~/.config/nvim/plugged')
  Plug 'Shougo/deoplete.nvim'
  Plug 'kassio/neoterm'
else 
  call plug#begin('~/.vim/plugged')
  Plug 'Valloric/YouCompleteMe'
endif

Plug 'rking/ag.vim'
Plug 'zyedidia/vim-snake'
Plug 'tpope/vim-fugitive'
Plug 'ensime/ensime-vim'
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'bling/vim-airline'
Plug 'majutsushi/tagbar'
Plug 'flazz/vim-colorschemes'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'derekwyatt/vim-scala'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
" Plug 'ktvoelker/sbt-vim'
Plug 'mileszs/ack.vim'       
Plug 'godlygeek/tabular'
Plug 'tpope/vim-markdown'
Plug 'suan/vim-instant-markdown'
Plug 'geverding/vim-hocon'
Plug 'HerringtonDarkholme/vim-worksheet'

call plug#end()

colorscheme molokai " Set colorscheme to inkpot. To see what colorschemes are available, check the contents of the directory ~/.vim/bundle/vim-colorschemes/ 

set sw=2       " Set tab width 2    
set sts=2      " Set tab width 2    
set expandtab  " Convert tabs to spaces
set rnu        " Enable Relative Line numbers
set nu
set cursorline " Highlight current line
set so=3

" Useful keymaps
noremap  <leader>n :NERDTreeToggle<CR>   " Ctrl+n to open/close file tree 
nnoremap <leader>o :EnDeclaration<CR>    " Ctrl+i to inspect the declaration under the cursor
nnoremap <leader>t :EnType<CR>           " Ctrl+t to see the type under the cursor

autocmd BufNewFile,BufRead *.scala   set ft=scala " Set syntax highlighting for .scala files
autocmd BufNewFile,BufRead *.sc      set ft=scala " Set syntax highlighting for scala worksheet files
au VimEnter,BufRead,BufNewFile *.sc call neoterm#test#libs#add('sbt console')

let g:airline_powerline_fonts = 1            " Use powerline fonts with airline. may need to switch terminal font to a powerline font. I use sourcecodepro powerline enabled
let g:airline#extensions#tabline#enabled = 1 
set laststatus=2 

let g:neoterm_repl_command = "sbt console"

let g:deoplete#enable_at_startup = 1
let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.scala = ['[^. *\t]\.\w*', '[:\[,] ?\w*', '^import .*']

let g:markdown_fenced_languages = ['sc=scala','tut=scala','sbt=scala', 'scala', 'sql']

let g:ycm_collect_identifiers_from_tags_files = 1
" Disable Arrow keys so you plebs stay on the home-row.
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

noremap ; :
" noremap : ;

" Nerd-tree configuration
autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = {
  \ 'dir':  '(\v[\/]\.(git|hg|svn)|(target)$',
  \ 'file': '\v\.(exe|so|dll|log|diag|html|class|uml)$',
  \ }

filetype plugin on

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

let g:syntastic_ignore_files = ['\m\c\.h$', '\m\.sbt$']

" Scala has fsc and scalac checkers--running both is pretty redundant and
" slow. An explicit `:SyntasticCheck scalac` can always run the other.
let g:syntastic_scala_checkers = ['fsc']

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

nnoremap <Leader>w :w<CR>

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR> 
nmap <silent> <c-l> :wincmd l<CR>



nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>
function! s:GrepOperator(type)
    let ft = expand('%:e')
    let unnamed_reg = @@

    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else 
        return
    endif

     silent execute "grep -R " . shellescape(@@) . " . --include='*." . ft . "'"
    copen

    let @@ = unnamed_reg
endfunction

let g:neoterm_position = 'vertical'
let g:neoterm_automap_keys = ',tt'

nnoremap <silent> <leader>r :call neoterm#clear()<cr>:TREPLSendFile<cr>

autocmd BufNewFile,BufRead *.json?* setfiletype json
