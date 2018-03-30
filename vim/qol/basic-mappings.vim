noremap  <leader>t :TagbarToggle<CR>   " space+t to open/close tag bar

" Replace word under wursor with text in clipboard
noremap  <leader>rwc viw"+p

" Move to the next buffer
nnoremap <leader>ll :bnext<CR>

" Move to the previous buffer
nnoremap <leader>hh :bprevious<CR>

" move parameter left
nnoremap <leader>H :SidewaysLeft<cr>

" move parameter right
nnoremap <leader>L :SidewaysRight<cr>

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

" Wordcount word under cursor in current file
nnoremap <leader>wc :%s/<C-R><C-W>//gn<CR>

" Override open tag in split.  Opens tags in vsplits instead
nnoremap <C-w>] :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Shift + ; is too hard.  Just use ;
noremap ; :

