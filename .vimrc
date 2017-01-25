"
" 無題のファイルをfiletype=text扱い
"
syntax on
set filetype=text
" filetype off
" filetype plugin indent off


""""""""""""""""""""""""NeoBundle設定""""""""""""""""""""""
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
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
noremap <Space>b :Unite buffer<CR>
" ファイル一覧
" noremap <Space>f :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <Space>m :Unite file_mru<CR>
" sourcesを「今開いているファイルのディレクトリ」とする
" cnoremap uff :<C-u>UniteWithBufferDir file -buffer-name=file
" ウィンドウを分割して開く
autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
autocmd FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
autocmd FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
autocmd FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
autocmd FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

" 非同期実行
NeoBundle 'Shougo/vimproc.vim',{
            \ "build": {
            \   "windows"   : "mingw32-make -f make_mingw64.mak",
            \   "cygwin"    : "make -f make_cygwin.mak",
            \   "mac"       : "make -f make_mac.mak",
            \   "unix"      : "make -f make_unix.mak",
            \ }}


NeoBundle 'Shougo/neomru.vim'
" neocomplete補完
" NeoBundleLazy 'Shougo/neocomplete.vim', {
"             \ "autoload": {"insert": 1}}
NeoBundle 'Shougo/neocomplete.vim'
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
" NeoBundleLazy 'h1mesuke/unite-outline',{
"             \ "autoload": {
"             \   "unite_sources": ["outline"],
"             \ },
"             \ }
"スニペット機能
NeoBundle 'Shougo/neosnippet.vim'
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
" Vimfilerの設定
let g:vimfiler_as_default_explorer = 1
nnoremap <silent> <C-\> :<C-u>VimFilerBufferDir -split -simple -winwidth=25 -toggle -no-quit<CR>
nnoremap <silent> <Space>f :<C-u>VimFilerBufferDir -split<CR>


" 置換機能の拡張
NeoBundle 'osyo-manga/vim-over'
" over.vimの起動
nnoremap  <Leader>/ :OverCommandLine<CR>%s///g<Left><Left><Left>
" 選択範囲を置換
vnoremap  <Leader>/ :OverCommandLine<CR>s///g<Left><Left><Left>
" カーソル下の単語をハイライト付きで置換
nnoremap  <Space>/ :OverCommandLine<CR>%s/<C-r><C-w>//g<Left><Left>
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
" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction
" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction

"テキスト整形
NeoBundle 'vim-scripts/Align'
"日本語への対応
let g:Align_xstrlen = 3

" " ヤンク履歴を取得・再利用
" NeoBundle 'LeafCage/yankround.vim'
" NeoBundle 'kien/ctrlp.vim'
" " キーマップ
" nmap p <Plug>(yankround-p)
" nmap P <Plug>(yankround-P)
" nmap <A-p> <Plug>(yankround-prev)
" nmap <A-n> <Plug>(yankround-next)
" " 履歴取得数
" let g:yankround_max_history = 50
" " 貼り付けた部分をハイライト
" let g:yankround_use_region_hl = 1
" " 履歴一覧(kien/ctrlp.vim)
" nnoremap <silent><Leader>y :<C-u>CtrlPYankRound<CR>
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

" ステータスライン表示強化
NeoBundle 'itchyny/lightline.vim'
" ブラウザを起動(gsで検索、gxでURLに移動)
NeoBundleLazy 'tyru/open-browser.vim',{
            \ 'autoload':{
            \ 'commands':['OpenBrowser','OpenBrowserSearch','OpenBrowserSmartSearch','<Plug>(openbrowser-smart-search)'],
            \ },}
let s:hooks = neobundle#get_hooks("open-browser.vim")
function! s:hooks.on_source(bundle)
    let g:netrw_nogx = 1 " disable netrw's gx mapping.
    nnoremap gs :OpenBrowserSmartSearch <C-r><C-w><CR>
    vnoremap gs y:OpenBrowserSmartSearch <C-r>"<CR>
    nnoremap gx :OpenBrowser <C-r><C-w><CR>
    vnoremap gx y:OpenBrowser <C-r>"<CR>
endfunction
nnoremap gs :OpenBrowserSmartSearch <C-r><C-w><CR>
vnoremap gs y:OpenBrowserSmartSearch <C-r>"<CR>
nnoremap gx :OpenBrowser <C-r><C-w><CR>
vnoremap gx y:OpenBrowser <C-r>"<CR>

" 行末の半角スペースを可視化
" NeoBundle 'bronson/vim-trailing-whitespace'
" プログラムを簡易実行
NeoBundleLazy 'thinca/vim-quickrun',{
            \'autoload':{
            \   'commands': ['QuickRun']
            \ },}
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


"Python編集用
"Python用補完
" NeoBundle 'davidhalter/jedi-vim'
" " jedi-vim設定
" let g:jedi#auto_initialization = 0
" let g:jedi#auto_vim_configuration = 0
" " nnoremap [jedi] <Nop>
" " xnoremap [jedi] <Nop>
" " nmap <Leader>j [jedi]
" " xmap <Leader>j [jedi]
" let g:jedi#completions_command = "<C-Space>"    " 補完キーの設定この場合はCtrl+Space
" let g:jedi#goto_assignments_command = "<Leader>g"   " 変数の宣言場所へジャンプ（Ctrl + g)
" let g:jedi#goto_definitions_command = "<Leader>d"   " クラス、関数定義にジャンプ（Ctrl + d）
" let g:jedi#documentation_command = "<C-k>"      " Pydocを表示（Ctrl + k）
" " let g:jedi#rename_command = "[jedi]r"
" " let g:jedi#usages_command = "[jedi]n"
" let g:jedi#popup_select_first = 0
" let g:jedi#popup_on_dot = 0
" autocmd FileType python setlocal completeopt-=preview
" " for w/ neocomplete
" autocmd FileType python setlocal omnifunc=jedi#completions
" let g:jedi#completions_enabled = 1
" let g:jedi#auto_vim_configuration = 0
" if !exists('g:neocomplete#force_omni_input_patterns')
"     let g:neocomplete#force_omni_input_patterns = {}
" endif
" let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
"

"html編集用
"ZenCoding適用
NeoBundleLazy 'mattn/emmet-vim', {
            \ 'autoload' : {
            \   'filetypes' : ['html', 'html5', 'eruby', 'jsp', 'xml', 'css', 'scss', 'coffee'],
            \   'commands' : ['<Plug>ZenCodingExpandNormal']
            \ },}


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

" カラースキーム読み込み
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'tomasr/molokai'
NeoBundle 'gosukiwi/vim-atom-dark'
NeoBundle 'geoffharcourt/one-dark.vim'


"css3、java-script、coffee-script、html5シンタックス表示
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'othree/html5.vim'
"txtファイル用のsyntax導入
NeoBundleLazy 'MU-lab/txt.vim'
autocmd FileType text setl syntax=txt

"PHITSのsyntax表示
NeoBundle 'JeanMichelBot/phits.vim'
" autocmd BufRead,BufNewFile *.inp,*.ou' set filetype=phits


"PowerShell編集用
NeoBundleLazy 'PProvost/vim-ps1',{
            \ 'autoload': {
            \ 'filetypes': ['ps1','ps1xml'],
            \ },
            \}
"自動で閉じカッコ挿入
NeoBundle 'Townk/vim-autoclose'

"NeoBundle設定の終了
NeoBundleCheck
call neobundle#end()
""""""""""""""""""""""""NeoBundle設定終了""""""""""""""""""""""""""""""""""""""""""


filetype plugin indent on       " restore filetype
" filetype on

" 全角スペースの表示
""""""""""""""""""""""""""""""
" function! ZenkakuSpace()
"     highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
" endfunction
"
"
" if has('syntax')
"     augroup ZenkakuSpace
"         autocmd!
"         autocmd ColorScheme * call ZenkakuSpace()
"         autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
"     augroup END
"     call ZenkakuSpace()
" endif


set t_Co=256

""Matlab用の設定
"autocmd BufEnter *.m    compiler mlint
"autocmd FileType matlab map <buffer> <silent> <F5> :w<CR>:!matlab -nodesktop -nospalsh -r "try, run(which('%')), pause, end, quit" <CR>\\|<ESC><ESC>
"autocmd FileType matlab set foldmethod=syntax foldcolumn=2 foldlevel=33

set number "行番号表示
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

" " Shift + 矢印でウィンドウサイズを変更
" nnoremap <S-Left>  <C-w><<CR>
" nnoremap <S-Right> <C-w>><CR>
" nnoremap <S-Up>    <C-w>-<CR>
" nnoremap <S-Down>  <C-w>+<CR>


set hlsearch "検索文字列をハイライトする
set incsearch "インクリメンタルサーチを行う
set ignorecase "大文字と小文字を区別しない
set smartcase "大文字と小文字が混在した言葉で検索を行った場合に限り、大文字と小文字を区別する
set wrapscan "最後尾まで検索を終えたら次の検索で先頭に移る
set showcmd "入力中のコマンドを表示
set nowrap "折り返しを無効
"set gdefault "置換の時 g オプションをデフォルトで有効にする
set list "不可視文字を表示
set encoding=cp932 " vimの内部文字コードをcp932に設定
" set encoding=utf-8 " vimの内部文字コードをcp932に設定
set fileencoding=utf-8 " ファイル書き込み時の文字コード(fileencoding)
set fileformat=unix " ファイル書き込み時の改行コード(fileformat)
set fileencodings=utf-8,utf-16,utf-16le,eucjp,cp932,sjis " 読み込み時の文字コード(fileencodings)
"set spell "spell設定
set backspace=indent,eol,start " backspaceの有効化
set cursorline "編集中行にライン表示

" Qでex-modeに入らない
nnoremap Q <Nop>

" Ctrl + hjkl でウィンドウ間を移動
" nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l

"Ctrl + 左右で行頭、行尾へ移動
nnoremap <C-Left>  0
nnoremap <C-Right> $
vnoremap <C-Left>  0
vnoremap <C-Right> $
"Ctrl + 上下で10行の移動
nnoremap <C-Up>  10k
nnoremap <C-Down> 10j
vnoremap <C-Up>  10k
vnoremap <C-Down> 10j
"Alt + 左右でバッファを移動
nnoremap <silent> <A-Left> :bp<CR>
nnoremap <silent> <A-Right> :bn<CR>

"deleteキーで文字削除
noremap  <delete>
":<Alt-q>で保存せず終了(:q!)
cnoremap <A-q> quit!
set expandtab "タブの代わりに空白文字を挿入する
set list "タブ文字、行末など不可視文字を表示する
set whichwrap=b,s,h,l,<,>,[,] "カーソルを行頭、行末で止まらないようにする
" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>
"スワップファイル用のディレクトリ
set directory=~/vimbackup
"undoファイル用のディレクトリ
set undodir=~/vimbackup
"backupを作成しない
set nowritebackup
set nobackup
"undoファイルを作成する(しない:set noundofile)
set noundofile
" 編集中に他のファイルを開ける
set hidden
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" ステータスバーを常に表示
set laststatus=2
" コマンドバーの高さ設定
set cmdheight=2
"ノーマルモードに入るときに英数入力へ切り替え
" set imdisable
set iminsert=1
set imsearch=-1

" <ctrl-a>、<ctrl-x>でインクリメント、デクリメント
"vunmap <C-x>
vnoremap <C-a> <C-a>gv
vnoremap <C-x> <C-x>gv
" インデント、インデント解除の設定
vnoremap > >gv
vnoremap < <gv
nnoremap > v>
nnoremap < v<

"%で対応箇所へ移動
source $VIMRUNTIME/macros/matchit.vim


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

"diff差分表示
function! s:vimdiff_in_newtab(...)
  if a:0 == 1
    exec 'vertical diffsplit ' . a:1
  endif
endfunction
command! -bar -nargs=+ -complete=file Diff  call s:vimdiff_in_newtab(<f-args>)

