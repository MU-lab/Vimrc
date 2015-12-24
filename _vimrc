"NeoBundle設定
filetype off            " for NeoBundle

"colorscheme molokai
"colorscheme morning
colorscheme default
"colorscheme hybrid
"colorscheme torte
"colorscheme jellybeans
"colorscheme twilight
"colorscheme lucius
"colorscheme railscasts
"colorscheme solarized
"colorscheme Wombat
"colorscheme rdark

syntax on
set t_Co=256

if has('vim_starting')
        set nocompatible
        set runtimepath+=c:/vim74-kaoriya-win64/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('c:/vim74-kaoriya-win64/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

" NeoBundle で管理するプラグインを追加します。
NeoBundleLazy 'Shougo/unite.vim.git',{
                        \ "autoload": {
                        \ "commands": ["Unite", "UniteWithBufferDir"]
                        \}}
" Unit.vimの設定
""""""""""""""""""""""""""""""
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
noremap <Space>b :Unite buffer<CR>
" ファイル一覧
noremap <Space>f :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <Space>m :Unite file_mru<CR>
" sourcesを「今開いているファイルのディレクトリ」とする
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
""""""""""""""""""""""""""""""

NeoBundle 'Shougo/vimproc.vim',{
                        \ "build": {
                        \   "windows"   : "mingw32-make -f make_mingw64.mak",
                        \   "cygwin"    : "make -f make_cygwin.mak",
                        \   "mac"       : "make -f make_mac.mak",
                        \   "unix"      : "make -f make_unix.mak",
                        \ }}

":Alt + s : シェルを起動
cnoremap <C-s> VimShellPop
NeoBundleLazy "Shougo/vimshell", { 'autoload' : { 'commands' :  [ "VimShell" ] } }
let s:bundle = neobundle#get("vimshell")
function! s:bundle.hooks.on_source(bundle)
        let g:vimshell_split_command = "split"
        let g:vimshell_prompt = $VIMUSERNAME."% "
        " ,ipy: pythonを非同期で起動
        "nnoremap <silent> ,ipy :VimShellInteractive python<CR>
        " ,irb: irbを非同期で起動
        "nnoremap <silent> ,irb :VimShellInteractive irb<CR>
        " ,ss: 非同期で開いたインタプリタに現在の行を評価させる
        "vmap <silent> ,ss :VimShellSendString<CR>
        " 選択中に,ss: 非同期で開いたインタプリタに選択行を評価させる
        "nnoremap <silent> ,ss <S-v>:VimShellSendString<CR>
endfunction
unlet s:bundle

NeoBundle 'Shougo/neomru.vim'
" neocomplete補完
NeoBundleLazy 'Shougo/neocomplete.vim', {
                        \ "autoload": {"insert": 1}}
let g:neocomplete#enable_at_startup = 1
let s:hooks = neobundle#get_hooks("neocomplete.vim")
function! s:hooks.on_source(bundle)
        let g:acp_enableAtStartup = 0
        let g:neocomplete#enable_smart_case = 1
        let g:neocomplete#sources#syntax#min_keyword_length = 3
        let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
        " Plugin key-mappings.
        inoremap <expr><C-g>     neocomplete#undo_completion()
        inoremap <expr><C-l>     neocomplete#complete_common_string()
        " Recommended key-mappings.
        " <CR>: close popup and save indent.
        inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
        function! s:my_cr_function()
                return pumvisible() ? neocomplete#close_popup() :"\<CR>"
        endfunction
        " <TAB>: completion.
        inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
        inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"
        " <C-h>, <BS>: close popup and delete backword char.
        inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
        inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
        inoremap <expr><C-y>  neocomplete#close_popup()
        inoremap <expr><C-e>  neocomplete#cancel_popup()
        " Close popup by <Space>.
        "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"
endfunction
autocmd FileType python setlocal omnifunc=python3complete#Complete

"クラスや関数名の一覧を表示
NeoBundleLazy 'Shougo/unite-outline',{
                        \ "autoload": {
                        \   "unite_sources": ["outline"]
                        \}}
"スニペット機能
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
"テキストオブジェクト拡張
NeoBundle 'tpope/vim-surround'
"ファイルエクスプローラー
NeoBundleLazy 'Shougo/vimfiler.vim',{
                        \ "depends": ["Shougo/unite.vim"],
                        \ "autoload": {
                        \   "commands": ["VimFilerTab", "VimFiler", "VimFilerExplorer"],
                        \   "mappings": ['<Plug>(vimfiler_switch)'],
                        \   "explorer": 1,
                        \ }}
"Vimfilerの設定
nnoremap <silent> <C-\> :<C-u>VimFilerBufferDir -split -simple -winwidth=25 -toggle -no-quit<CR>

" インデントに色を付けて見やすくする
NeoBundle 'nathanaelkane/vim-indent-guides'
let s:hooks = neobundle#get_hooks("vim-indent-guides")
function! s:hooks.on_source(bundle)
        " Vim 起動時 vim-indent-guides を自動起動
        let g:indent_guides_enable_on_vim_startup=1
        " ガイドをスタートするインデントの量
        let g:indent_guides_start_level=2
        " 自動カラー無効
        let g:indent_guides_auto_colors=0
        " 奇数番目のインデントの色
        autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#444433 ctermbg=black
        " 偶数番目のインデントの色
        autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#333344 ctermbg=darkgray
        " ガイドの幅
        let g:indent_guides_guide_size = 1
endfunction

" <Leader>gでundoを一覧表示
NeoBundleLazy "sjl/gundo.vim", {
                        \ "autoload": {
                        \   "commands": ['GundoToggle'],
                        \}}
nnoremap <Leader>g :GundoToggle<CR>

"<Leader>Tでタスクリスト表示
NeoBundleLazy "vim-scripts/TaskList.vim", {
                        \ "autoload": {
                        \   "mappings": ['<Plug>TaskList'],
                        \}}
nmap <Leader>T <plug>TaskList

"テキスト整形
NeoBundle 'vim-scripts/Align'

NeoBundle 'vim-scripts/YankRing.vim'
nnoremap <Leader>y :YRShow<CR>
" クリップボード共有
set clipboard+=unnamedplus,unnamed

"コメントアウト設定
NeoBundle 'tomtom/tcomment_vim'
"デフォルトのキーマッピングを無効化
let g:tcommentMap = 0
" Alt-\でコメントアウト
noremap <silent> <A-\>  :TComment<CR>
"let g:tcommentMapLeader1 = '<C-\>'     "     (default: '<c-_>')
"let g:tcommentMapLeader2 = '<Leader>\'  "        (default: '<Leader>_')
"let g:tcommentMapLeaderOp1 = 'gc'      "  (default: 'gc')
" let g:tcommentMapLeaderOp2 = 'gC'      "  (default: 'gC')

"Tagbarの表示
NeoBundleLazy 'majutsushi/tagbar', {
                        \ "autload": {
                        \   "commands": ["TagbarToggle"],
                        \ }}
nmap <Leader>t :TagbarToggle<CR>

" 行末の半角スペースを可視化
NeoBundle 'bronson/vim-trailing-whitespace'

"プログラムを簡易実行
NeoBundleLazy 'thinca/vim-quickrun',{
                        \'autload':{
                        \   'commands': ['QuickRun']
                        \ }}
"quickrun設定
let g:quickrun_no_default_key_mappings = 1
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : '\<C-c>'
nnoremap <A-r> :QuickRun<CR>
let s:hooks = neobundle#get_hooks("vim-quickrun")
function! s:hooks.on_source(bundle)
        let g:quickrun_config = {
                                \ '*': {"runner": 'remote/vimproc'},
                                \ '_' : {
                                \ 'outputter' : 'multi:buffer:quickfix',
                                \ 'outputter/buffer/split' : ':botright 60vsp',
                                \}}
endfunction

"html編集用
"ZenCoding適用
NeoBundle 'mattn/emmet-vim'
let g:user_emmet_mode = 'i'
let g:user_emmet_leader_key = '<tab>'
let g:use_emmet_complete_tag = 1
let g:user_emmet_settings = {
                        \ 'lang' : 'ja',
                        \ 'html' : {
                        \   'filters' : 'html',
                        \ },
                        \ 'css' : {
                        \   'filters' : 'fc',
                        \ },
                        \ 'php' : {
                        \   'extends' : 'html',
                        \   'filters' : 'html',
                        \ },
                        \}
augroup EmmitVim
        autocmd!
        autocmd FileType * let g:user_emmet_settings.indentation = '               '[:&tabstop]
augroup END

augroup VimCSS3Syntax
        autocmd!
        autocmd FileType css setlocal iskeyword+=-
augroup END

"css、java-script、coffee-scriptシンタックス表示
NeoBundleLazy 'hail2u/vim-css3-syntax',{
                        \ "autolaod": {
                        \ "filetypes": ["css"],
                        \ },
                        \ }
NeoBundleLazy 'jelera/vim-javascript-syntax',{
                        \ "autolaod": {
                        \ "filetypes": ["js"],
                        \ },
                        \ }
NeoBundleLazy 'kchmck/vim-coffee-script',{
                        \ "autolaod": {
                        \ "filetypes": ["coffee"],
                        \ },
                        \ }

"PowerShell編集用
NeoBundleLazy 'PProvost/vim-ps1',{
                        \ 'autolaod': {
                        \ 'filetypes': ['ps1','ps1xml'],
                        \ },
                        \}
"自動で閉じカッコ挿入
NeoBundle 'Townk/vim-autoclose'

"tex編集用
" NeoBundle 'vim-latex/vim-latex'
NeoBundleLazy 'vim-latex/vim-latex',{
                        \'autload':{
                        \"filetypes":["latex","tex"],
                        \},}
"vim-latexの設定
let s:hooks = neobundle#get_hooks("vim-latex")
function! s:hooks.on_source(bundle)
        set shellslash
        set grepprg=grep\ -nH\ $*
        let g:tex_flavor='latex'
        let g:Imap_UsePlaceHolders = 1
        let g:Imap_DeleteEmptyPlaceHolders = 1
        let g:Imap_StickyPlaceHolders = 0
        let g:Tex_DefaultTargetFormat = 'pdf'
        let g:Tex_MultipleCompileFormats='dvi,pdf'
        "let g:Tex_FormatDependency_pdf = 'pdf'
        let g:Tex_FormatDependency_pdf = 'dvi,pdf'
        "let g:Tex_FormatDependency_pdf = 'dvi,ps,pdf'
        let g:Tex_FormatDependency_ps = 'dvi,ps'
        let g:Tex_CompileRule_pdf = 'ptex2pdf -u -l -ot "-kanji=utf8 -no-guess-input-enc -synctex=1 -interaction=nonstopmode -file-line-error-style" $*'
        "let g:Tex_CompileRule_pdf = 'pdflatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
        "let g:Tex_CompileRule_pdf = 'lualatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
        "let g:Tex_CompileRule_pdf = 'luajitlatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
        "let g:Tex_CompileRule_pdf = 'xelatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
        "let g:Tex_CompileRule_pdf = 'ps2pdf.exe $*.ps'
        let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
        let g:Tex_CompileRule_dvi = 'uplatex -kanji=utf8 -no-guess-input-enc -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
        let g:Tex_BibtexFlavor = 'upbibtex'
        let g:Tex_MakeIndexFlavor = 'upmendex $*.idx'
        let g:Tex_ViewRule_pdf = 'rundll32 shell32,ShellExec_RunDLL SumatraPDF -reuse-instance -inverse-search "\"' . $VIM . '\gvim.exe\" -n -c \":RemoteOpen +\%l \%f\""'
        "let g:Tex_ViewRule_pdf = 'texworks'
        "let g:Tex_ViewRule_pdf = 'rundll32 shell32,ShellExec_RunDLL firefox -new-window'
        "let g:Tex_ViewRule_pdf = 'powershell -Command "& {$p = [System.String]::Concat(''"""'',[System.IO.Path]::GetFullPath($args),''"""'');Start-Process chrome -ArgumentList (''--new-window'',$p)}"'
        "let g:Tex_ViewRule_pdf = 'pdfopen --r15 --file'
endfunction

"Python編集用
"ローカル変数をハイライト
NeoBundleLazy 'hachibeeDI/python_hl_lvar.vim',{
                        \ "autolaod": {
                        \ "filetypes": ["python","python3"],
                        \ },
                        \}
"関数やクラスをテキストオブジェクト化
"Python用補完
NeoBundleLazy 'davidhalter/jedi-vim',{
                        \ "autolaod": {
                        \ "filetypes": ["pyhton","python3","djangohtml"],
                        \ },
                        \ }
" jedi-vim設定
let s:hooks = neobundle#get_hooks("jedi-vim")
function! s:hooks.on_source(bundle)
        autocmd FileType python setlocal omnifunc=jedi#completions
        let g:jedi#completions_enabled = 0
        let g:jedi#auto_vim_configuration = 0
        if !exists('g:neocomplete#force_omni_input_patterns')
                let g:neocomplete#force_omni_input_patterns = {}
        endif
        let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'
endfunction

filetype plugin indent on       " restore filetype
filetype indent on

"NeoBundle設定の終了
NeoBundleCheck
call neobundle#end()

" 全角スペースの表示
""""""""""""""""""""""""""""""
function! ZenkakuSpace()
        highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
        augroup ZenkakuSpace
                autocmd!
                autocmd ColorScheme * call ZenkakuSpace()
                autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
        augroup END
        call ZenkakuSpace()
endif

"PHITSのsyntax表示
au BufRead,BufNewFile *.inp,*.out set filetype=phits
"Matlab用の設定
autocmd BufEnter *.m    compiler mlint
au FileType matlab map <buffer> <silent> <F5> :w<CR>:!matlab -nodesktop -nospalsh -r "try, run(which('%')), pause, end, quit" <CR>\\|<ESC><ESC>
au FileType matlab set foldmethod=syntax foldcolumn=2 foldlevel=33

set splitbelow
set splitright
"grep時に自動でquickfixする
autocmd QuickFixCmdPost *grep* cwindow
"折り返し行中の上下移動有効化
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk

"スクリーンベル無効化
set t_vb=
set noerrorbells
set visualbell


" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

" Ctrl + hjkl でウィンドウ間を移動
" nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l

"Pythonファイルではtabをスペース4個に置き換え
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4
"setl tabstop=8 expandtab shiftwidth=4 softtabstop=4

" txtファイル用のsyntax設定
autocmd FileType text setl syntax=txt

"spell設定
"set spell

"Ctrl + 左右で行頭、行尾へ移動
nnoremap <C-Left>  0
nnoremap <C-Right> $
vnoremap <C-Left>  0
vnoremap <C-Right> $
"Alt + 左右でバッファを移動
nnoremap <silent> <A-Left> :bp<CR>
nnoremap <silent> <A-Right> :bn<CR>

":<Alt-q>で保存せず終了(:q!)
cnoremap <A-q> quit!
"タブの代わりに空白文字を挿入する
set expandtab
"タブ文字、行末など不可視文字を表示する
set list
"カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>
"スワップファイル用のディレクトリ
set directory=C:/vim74-kaoriya-win64/vimbackup
"undoファイル用のディレクトリ
set undodir=C:/vim74-kaoriya-win64/vimundo

" 検索結果をハイライト
set hlsearch

" ステータスバーを常に表示
set laststatus=2
" コマンドバーの高さ設定
set cmdheight=2

"%で対応箇所へ移動
source $VIMRUNTIME/macros/matchit.vim
" vを二回で行末まで選択
"vnoremap v $h
"backupを作成しない
set nowritebackup
set nobackup

" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
  endfunction

" Set tabline.
function! s:my_tabline()  "{{{
        let s = ''
        for i in range(1, tabpagenr('$'))
                let bufnrs = tabpagebuflist(i)
                let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
                let no = i  " display 0-origin tabpagenr.
                let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
                let title = fnamemodify(bufname(bufnr), ':t')
                let title = '[' . title . ']'
                let s .= '%'.i.'T'
                let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
                let s .= no . ':' . title
                let s .= mod
                let s .= '%#TabLineFill# '
        endfor
        let s .= '%#TabLineFill#%T%=%#TabLine#'
        return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
"set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]

" Tab jump
for n in range(1, 9)
        execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
noremap  [Tag]c :tablast <bar> tabnew
" tc 新しいタブを一番右に作る
noremap <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
noremap <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
noremap <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ


