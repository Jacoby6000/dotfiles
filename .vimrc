" Vundle initialization
set nocompatible             
filetype off                  
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'ensime/ensime-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'derekwyatt/vim-scala'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'majutsushi/tagbar'
Plugin 'flazz/vim-colorschemes'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdcommenter'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" Vundle initialization over

colorscheme molokai " Set colorscheme to inkpot. To see what colorschemes are available, check the contents of the directory ~/.vim/bundle/vim-colorschemes/ 

set sw=2       " Set tab width 2    
set sts=2      " Set tab width 2    
set expandtab  " Convert tabs to spaces
set incsearch  " Have searching highlight the matching things
set rnu        " Enable Relative Line numbers
set cursorline " Highlight current line
set so=3
syntax on      " Enable syntax highlighting 

" Useful keymaps
map <C-n> :NERDTreeToggle<CR>   " Ctrl+n to open/close file tree 
map <C-p> :CtrlP<CR>            " Ctrl+p to run ctrlp fuzzy file finder
map <C-tab> :EnCompleteFunc<CR> " Ctrl+tab to check autocomplete
map <C-i> :EnDeclaration<CR>    " Ctrl+i to inspect the declaration under the cursor
map <C-t> :EnType<CR>           " Ctrl+t to see the type under the cursor

autocmd BufNewFile,BufRead *.scala   set ft=scala " Set syntax highlighting for .scala files
autocmd BufNewFile,BufRead *.sc      set ft=scala " Set syntax highlighting for scala worksheet files

let g:airline_powerline_fonts = 1            " Use powerline fonts with airline. may need to switch terminal font to a powerline font. I use sourcecodepro powerline enabled
let g:airline#extensions#tabline#enabled = 1 
set laststatus=2 

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
noremap : ;

" Nerd-tree configuration
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|xml|log|diag|html|class|uml)$',
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
