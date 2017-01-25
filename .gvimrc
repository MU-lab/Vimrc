"colorscheme molokai
"colorscheme hybrid
colorscheme atom-dark
" colorscheme onedark
" let g:onedark_termcolors=16
set background=dark

if has('win32')
        " set guifont=MS_Gothic:h12:cSHIFTJIS
        set guifont=HGｺﾞｼｯｸM:h12:cSHIFTJIS:qDRAFT 
elseif has('unix')
        set guifont=DejaVu\ Sans\ Mono\ 12
endif

" タブ設定
" Anywhere SID.
" function! s:SID_PREFIX()
"     return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
" endfunction
" " Set tabline.
" function! s:my_tabline()  "{{{
"     let s = ''
"     for i in range(1, tabpagenr('$'))
"         let bufnrs = tabpagebuflist(i)
"         let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
"         let no = i  " display 0-origin tabpagenr.
"         let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
"         let title = fnamemodify(bufname(bufnr), ':t')
"         let title = '[' . title . ']'
"         let s .= '%'.i.'T'
"         let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
"         let s .= no . ':' . title
"         let s .= mod
"         let s .= '%#TabLineFill# '
"     endfor
"     let s .= '%#TabLineFill#%T%=%#TabLine#'
"     return s
" endfunction "}}}
" let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
"set showtabline=2 " 常にタブラインを表示

noremap <space><tab> :VimFilerTab<CR>
" <space><tab> 新しいタブを一番右に作る
" noremap <silent> <C-tab> :tabnext<CR> 
" " ctrl-tab 次のタブ 
" noremap <silent> <C-S-tab> :tabprevious<CR> 
" " shift-ctrl-tab 前のタブ 

set guioptions-=m
set guioptions-=T

" ウインドウの幅 
" set columns= 
" ウインドウの高さ 
" set lines= 
" コマンドラインの高さ(GUI使用時) 
set cmdheight=2 
" gvim起動時全画面 
au GUIEnter * simalt ~x 

