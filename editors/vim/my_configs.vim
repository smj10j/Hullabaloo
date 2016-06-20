nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" Map F1 for gvim window resizing.
" Put this snippet of code in your vimrc for nice window resizing.
" Press F1 key to toggle between the three settings.
nmap <F1> :call ResizeWindow()<CR>
imap <F1> <Esc><F1>a " for insert mode
function! ResizeWindow()
  if (has("gui"))
    if s:selectedsize == 1
      let s:selectedsize = 2
      set number
      set columns=88 " 88 is exactly 80 with :set number
      set lines=35
    elseif s:selectedsize == 2
      set number
      let s:selectedsize = 3
      set columns=190
      set lines=35
    else " old school console goodness
      let s:selectedsize = 1
      set nonumber
      set columns=170
      set lines=50
    endif
  endif
endfunction
let s:selectedsize=1
call ResizeWindow()

" Override someone setting foldlevel too low
set foldmethod=indent
set foldlevel=20

" Wakatime
" source ~/.hullabaloo/editors/vim/vim-wakatime/plugin/wakatime.vim
