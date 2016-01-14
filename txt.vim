" Vim syntax file
" Language:	PlainText
" Maintainer:	Calon <calon.xu@gmail.com>
" URL:		http://calon,weblogs.us/
" Last Update:  2010-12-12 21:00

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'txt'
endif

":so $VIMRUNTIME/syntax/html.vim

syn case ignore

syn cluster AlwaysContains add=Errors
syn cluster NormalContains add=Numbers,CPM,EPM,Links,Letters
syn cluster QuoteContains  add=Quoted,SingleQuoted,Bracketed

" English Punctuation Marks
syn match EPM "[~\-_+*<>\[\]{}=|#@$%&\\/:&\^\.,!?]"

syn match Letters "[A-Za-z]"

" Normal Chinese Punctuation Marks
syn match CPM "[，。；：！？、《》【】“”‘’（）『』「」????〔〕〈〉…￥・■◆▲●★□◇△○☆＄‰￥℃※±????????????????????????????????????????①②③④⑤⑥⑦⑧⑨⑩??????????→←↑↓§№◎ⅠⅡⅢⅣⅤⅥⅦⅧⅨⅩ???≡≠＝??＜＞???±＋－×÷／∫∮∝∞∧∨∑?∪∩∈∵∴⊥∥∠⌒??∽√°?￠〇]"

" 数字
syn match Numbers "\d\(\.\d\+\)\?"
syn match Numbers "\d"

" internet address
syn match Links   "\(http\|https\|ftp\)\(\w\|[\-&=,?\:\.\/]\)*"  contains=CPM

" 括弧
syn region Bracketed         matchgroup=CPM  start="[（]"        end="[）]"
syn region Quoted            matchgroup=EPM  start="\""          end="\""
syn region Quoted            matchgroup=CPM  start="[《]"        end="[》]"
syn region Quoted            matchgroup=CPM  start="[“]"        end="[”]"
syn region Quoted            matchgroup=CPM  start="[『]"        end="[』]"
syn region Quoted            matchgroup=CPM  start="[【]"        end="[】]"
syn region Quoted            matchgroup=CPM  start="[?]"        end="[?]"
syn region Quoted            matchgroup=CPM  start="[〔]"        end="[〕]"
syn region Quoted            matchgroup=EPM  start="\(\s\|^\)\@<='" end="'"
syn region SingleQuoted      matchgroup=CPM  start="[〈]"        end="[〉]"
syn region SingleQuoted      matchgroup=CPM  start="[「]"        end="[」]"
syn region SingleQuoted      matchgroup=CPM  start="[‘]"        end="[’]"
syn region SingleQuoted      matchgroup=CPM  start="[?]"        end="[?]"
syn region Comments          matchgroup=EPM  start="("           end=")"
syn region Comments          matchgroup=Comments start="\/\/"    end="$"
syn region Comments          matchgroup=Comments start="\/\*"    end="\*\/"
syn region Tags              matchgroup=EPM  start="<"           end=">"
syn region Tags              matchgroup=EPM  start="{"           end="}"
syn region Tags              matchgroup=EPM  start="\["          end="\]"

syn keyword Errors error bug warning fatal rtfm

syn case match
" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
  if version < 508
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink Numbers              Number
  HiLink CPM                  String
  " HiLink EPM                  Tag
  HiLink EPM                  Operator
  HiLink Bracketed            Delimiter
  HiLink Quoted               Label
  HiLink SingleQuoted         Structure
  HiLink Comments             Comment
  HiLink Links                Underlined
  HiLink Tags                 Function
  " HiLink Letters              Identifier
  delcommand HiLink

  hi Errors                   ctermfg=red guifg=red

let b:current_syntax = "txt"


