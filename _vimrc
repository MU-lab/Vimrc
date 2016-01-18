"NeoBundle設定

" 無題のファイルをfiletype=text扱い
set filetype=text

syntax on

if has('vim_starting')
    set nocompatible
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle'))
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

" 非同期実行
NeoBundle 'Shougo/vimproc.vim',{
            \ "build": {
            \   "windows"   : "mingw32-make -f make_mingw64.mak",
            \   "cygwin"    : "make -f make_cygwin.mak",
            \   "mac"       : "make -f make_mac.mak",
            \   "unix"      : "make -f make_unix.mak",
            \ }}

":Ctrl + s : シェルを起動
cnoremap <C-s> VimShellPop
NeoBundleLazy "Shougo/vimshell", { 'autoload' : { 'commands' :  [ "VimShell",'VimShellSendString',"VimShellInteractive",'VimShellCurrentDir' ] } }
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
" autocmd FileType python setlocal omnifunc=python3complete#Complete

"クラスや関数名の一覧を表示
NeoBundleLazy 'Shougo/unite-outline',{
            \ "autoload": {
            \   "unite_sources": ["outline"],
            \ },
            \ }
"スニペット機能
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
imap <C-s> <Plug>(neosnippet_expand_or_jump)
smap <C-s> <Plug>(neosnippet_expand_or_jump)

"テキストオブジェクト拡張
NeoBundle 'tpope/vim-surround'
"ファイルエクスプローラー
NeoBundleLazy 'Shougo/vimfiler.vim',{
            \"depends": ["Shougo/unite.vim"],
            \"autoload": {
            \"commands": ["VimFilerTab", "VimFiler", "VimFilerExplorer"],
            \"mappings": ['<Plug>(vimfiler_switch)'],
            \"explorer": 1,}}
"Vimfilerの設定
nnoremap <silent> <C-\> :<C-u>VimFilerBufferDir -split -simple -winwidth=25 -toggle -no-quit<CR>

" 置換機能の拡張
NeoBundle 'osyo-manga/vim-over'
" over.vimの起動
nnoremap  <Leader>/ :OverCommandLine<CR>%s///g<Left><Left><Left>
" カーソル下の単語をハイライト付きで置換
nnoremap  <Leader>m :OverCommandLine<CR>%s/<C-r><C-w>//g<Left><Left>
" コピーした文字列をハイライト付きで置換
" nnoremap subp y:OverCommandLine<CR>%s!<C-r>=substitute(@0, '!', '\\!', 'g')<CR>!!gI<Left><Left><Left>

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

" マルチカーソル設定
NeoBundle 'terryma/vim-multiple-cursors'
" Default mapping
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
let g:multi_cursor_start_key='<C-n>'
let g:multi_cursor_start_word_key='g<C-n>'

"テキスト整形
NeoBundle 'vim-scripts/Align'

" ヤンク履歴を取得・再利用
NeoBundle 'LeafCage/yankround.vim'
NeoBundle 'kien/ctrlp.vim'
" キーマップ
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-.> <Plug>(yankround-prev)
nmap <C-,> <Plug>(yankround-next)
"" 履歴取得数
let g:yankround_max_history = 50
""履歴一覧(kien/ctrlp.vim)
nnoremap <silent><Leader>y :<C-u>CtrlPYankRound<CR>

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
"let g:tcommentMapLeaderOp2 = 'gC'      "  (default: 'gC')

"Tagbarの表示
NeoBundleLazy 'majutsushi/tagbar', {
            \ "autoload": {
            \   "commands": ["TagbarToggle"],
            \ }}
nmap <Leader>t :TagbarToggle<CR>

" ステータスライン表示強化
NeoBundle 'itchyny/lightline.vim'

" 行末の半角スペースを可視化
" NeoBundle 'bronson/vim-trailing-whitespace'

"プログラムを簡易実行
NeoBundleLazy 'thinca/vim-quickrun',{
            \'autoload':{
            \   'commands': ['QuickRun']
            \ }}
"quickrun設定
let g:quickrun_no_default_key_mappings = 1
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : '\<C-c>'
nnoremap <A-r> :QuickRun<CR>
let g:quickrun_config = {
            \ '*': {"runner": 'remote/vimproc'},
            \ '_' : {
            \ 'outputter' : 'multi:buffer:quickfix',
            \ 'outputter/buffer/split' : ':botright 60vsp',
            \}}

" " texファイルをコンパイル
" function! s:StartTexFile()
"     " LaTeX Quickrun
"     let g:quickrun_config = {
"                 \ '_' : {
"                 \ 'outputter' : 'multi:buffer:quickfix',
"                 \ 'outputter/buffer/split' : ':botright 8sp',
"                 \   }
"                 \}
"     let g:quickrun_config['tex'] = {
"                 \ 'command' : 'latexmk',
"                 \ 'outputter' : 'error',
"                 \ 'outputter/error/error' : 'quickfix',
"                 \ 'srcfile' : expand("%"),
"                 \ 'cmdopt': '-pdfdvi',
"                 \ 'exec': ['%c %o %s'],
"                 \}
"     " 部分的に選択してコンパイル
"     " http://auewe.hatenablog.com/entry/2013/12/25/033416 を参考に
"     let g:quickrun_config.tmptex = {
"                 \   'exec': [
"                 \           'mv %s %a/tmptex.latex',
"                 \           'latexmk -pdfdvi -pv -output-directory=%a %a/tmptex.latex',
"                 \           ],
"                 \   'args' : expand("%:p:h:gs?\\\\?/?"),
"                 \   'outputter' : 'error',
"                 \   'outputter/error/error' : 'quickfix',
"                 \
"                 \   'hook/eval/enable' : 1,
"                 \   'hook/eval/cd' : "%s:r",
"                 \
"                 \   'hook/eval/template' : '\documentclass{jsarticle}'
"                 \                         .'\usepackage[dvipdfmx]{graphicx, hyperref}'
"                 \                         .'\usepackage{float}'
"                 \                         .'\usepackage{amsmath,amssymb,amsthm,ascmac,mathrsfs}'
"                 \                         .'\allowdisplaybreaks[1]'
"                 \                         .'\theoremstyle{definition}'
"                 \                         .'\newtheorem{theorem}{定理}'
"                 \                         .'\newtheorem*{theorem*}{定理}'
"                 \                         .'\newtheorem{definition}[theorem]{定義}'
"                 \                         .'\newtheorem*{definition*}{定義}'
"                 \                         .'\renewcommand\vector[1]{\mbox{\boldmath{\$#1\$}}}'
"                 \                         .'\begin{document}'
"                 \                         .'%s'
"                 \                         .'\end{document}',
"                 \
"                 \   'hook/sweep/files' : [
"                 \                        '%a/tmptex.latex',
"                 \                        '%a/tmptex.out',
"                 \                        '%a/tmptex.fdb_latexmk',
"                 \                        '%a/tmptex.log',
"                 \                        '%a/tmptex.aux',
"                 \                        '%a/tmptex.dvi'
"                 \                        ],
"                 \}
"     vnoremap <silent><buffer> <A-r> :QuickRun -mode v -type tmptex<CR>
" endfunction
" function! s:texPDFView()
"     let texFileName = expand("%:r").'.pdf'
"     let cmdPDFView = 'C:/"Program Files"/SumatraPDF/SumatraPDF.exe -reuse-instance '.texFileName
"     echo vimproc#cmd#system(cmdPDFView)
" endfunction
" autocmd FileType tex call <SID>StartTexFile()
" autocmd FileType tex nnoremap <Leader>v :call <SID>texPDFView()<CR>

" tex編集用
NeoBundleLazy 'vim-latex/vim-latex',{
            \ 'autoload':{
            \ 'filetypes':['tex','latex'],
            \},
            \}
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
    let g:Tex_FormatDependency_pdf = 'dvi,pdf'
    let g:Tex_FormatDependency_ps = 'dvi,ps'
    let g:Tex_CompileRule_pdf = 'ptex2pdf -l -ot "-kanji=utf-8 -no-guess-input-enc -synctex=1 -interaction=nonstopmode -file-line-error-style" $*'
    let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
    let g:Tex_CompileRule_dvi = 'uplatex -kanji=utf-8 -no-guess-input-enc -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
    let g:Tex_BibtexFlavor = 'pbibtex'
    let g:Tex_MakeIndexFlavor = 'pmendex $*.idx'
    let g:Tex_ViewRule_pdf = 'rundll32 shell32,ShellExec_RunDLL SumatraPDF -reuse-instance -inverse-search "\"' . $VIM . '\gvim.exe\" -n -c \":RemoteOpen +\%l \%f\""'
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
            \   'filters' : ['c','html'],
            \ },
            \ }
augroup EmmitVim
    autocmd!
    autocmd FileType * let g:user_emmet_settings.indentation = '               '[:&tabstop]
augroup END

augroup VimCSS3Syntax
    autocmd!
    autocmd FileType css setlocal iskeyword+=-
augroup END

" html5文法チェック
NeoBundleLazy 'hokaccha/vim-html5validator',{
            \ "autoload": {
            \ "filetypes": ["html"],
            \ },
            \ }

" カラースキーム読み込み
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'tomasr/molokai'

"css3、java-script、coffee-script、html5シンタックス表示
NeoBundleLazy 'hail2u/vim-css3-syntax',{
            \ "autoload": {
            \ "filetypes": ["css"],
            \ },
            \ }
NeoBundleLazy 'jelera/vim-javascript-syntax',{
            \ "autoload": {
            \ "filetypes": ["js"],
            \ },
            \ }
NeoBundleLazy 'kchmck/vim-coffee-script',{
            \ "autoload": {
            \ "filetypes": ["coffee"],
            \ },
            \ }
NeoBundleLazy 'othree/html5.vim',{
            \ 'autoload':{
            \ 'filetypes':['html'],
            \},
            \}
"txtファイル用のsyntax導入
 NeoBundleLazy 'MU-lab/txt.vim', {
             \ "autoload":{
             \ "filetypes":["txt","text"],
             \ },
             \ }
autocmd FileType text setl syntax=txt

"PHITSのsyntax表示
NeoBundle 'JeanMichelBot/phits.vim'
au BufRead,BufNewFile *.inp,*.ou' set filetype=phits

"PowerShell編集用
NeoBundleLazy 'PProvost/vim-ps1',{
            \ 'autoload': {
            \ 'filetypes': ['ps1','ps1xml'],
            \ },
            \}
"自動で閉じカッコ挿入
NeoBundle 'Townk/vim-autoclose'

"Python編集用
"ローカル変数をハイライト
NeoBundleLazy 'hachibeeDI/python_hl_lvar.vim',{
            \ "autoload": {
            \ "filetypes": ["python","python3"],
            \ },
            \}
"関数やクラスをテキストオブジェクト化
"Python用補完
NeoBundleLazy 'davidhalter/jedi-vim',{
            \ "autoload": {
            \ "filetypes": ["python","python3","djangohtml"],
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

set t_Co=256
"colorscheme default
colorscheme desert
" colorscheme industry
" colorscheme elflord
" colorscheme wombat
" colorscheme rdark

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

" インデント設定(デフォルト)
set autoindent
set smartindent     " indent when
set tabstop=4       " tab width
set softtabstop=4   " backspace
set shiftwidth=4    " indent width
set expandtab       " expand tab to space
" インデント設定(filetype依存)
autocmd FileType php setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType php setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType coffee,javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType html,htmldjango,xhtml,haml setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType sass,scss,css setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType tex,latex setlocal smartindent cinwords=begin
autocmd FileType tex,latex setlocal tabstop=2 shiftwidth=2 softtabstop=2


" vimの内部文字コードをutf-8に設定
" set encoding=utf-8
" ファイル書き込み時の文字コード(fileencoding)
set fileencoding=utf-8
" 読み込み時の文字コード(fileencodings)
set fileencodings=utf-8,cp932

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
set directory=~/vimbackup
"undoファイル用のディレクトリ
set undodir=~/vimbackup
"backupを作成しない
set nowritebackup
set nobackup
"undoファイルを作成しない
set noundofile
" 検索結果をハイライト
set hlsearch
" 編集中に他のファイルを開ける
set hidden
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" ステータスバーを常に表示
set laststatus=2
" コマンドバーの高さ設定
set cmdheight=2
" defaultのshellをPowerShellに設定
" if !has('unix')
"     set shell=powershell.exe
"     set shellcmdflag=-c
"     set shellquote=\"
"     set shellxquote=
" endif

"%で対応箇所へ移動
source $VIMRUNTIME/macros/matchit.vim

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


