let $RUBY_DLL = "/opt/local/lib/libruby.dylib"
let $PYTHON_DLL = "/opt/local/lib/libpython2.6.dylib"
let $PERL_DLL = "/opt/local/lib/perl5/5.8.9/darwin-2level/CORE/libperl.a"
scriptencoding utf-8
set nocompatible
"scriptencodingと、このファイルのエンコードが一致するよう注意！
"scriptencodingは、vimの内部エンコードと同じにすると問題が起きにくい。
"改行コードは set fileformat=unix に設定するとunixでも使えます。

"----------------------------------------
" システム設定
"----------------------------------------
"unix,win32でのpathの違いを吸収
"$CFGHOMEはユーザーランタイムディレクトリを示す。
"ランタイムパスを通す必要のあるプラグインを使用する場合、
"$CFGHOMEを使用すると Windows/Linuxで切り分ける必要が無くなる。
"例) vimfiles/qfixapp (Linuxでは~/.vim/qfixapp)にランタイムパスを通す場合。
"set runtimepath+=$CFGHOME/qfixapp
if has('unix')
  let $CFGHOME=$HOME.'/.vim'
else
  let $CFGHOME=$VIM.'/vimfiles'
endif

"UTF-8化を_vimrcで行う場合以下を有効にする。
"source $CFGHOME/pluginjp/encode.vim
"_vimrcでscriptencodingと異なる内部エンコーディングに変更する場合、
"変更後に改めてscriptencodingを指定しておくと問題が起きにくくなります。
"scriptencoding cp932

"mswin.vimを読み込む
"source $VIMRUNTIME/mswin.im
"behave mswin

set langmenu=none

"ファイルの上書きの前にバックアップを作る/作らない
"set writebackupを指定してもオプション 'backup' がオンでない限り、
"バックアップは上書きに成功した後に削除される。
set nowritebackup
"バックアップ/スワップファイルを作成する/しない。
set nobackup
set backupdir=/Documents
set directory-=.
"一定時間入力がないとき、バッファを自動保存する。
" set autowrite
" set autowriteall
" autocmd CursorHold * wall
" autocmd CursorHoldI * wall
"set noswapfile
"viminfoを作成しない。
"set viminfo=
"クリップボードを共有。
set clipboard+=unnamed
"8進数を無効にする。<C-a>,<C-x>などに影響する。
"set nrformats-=octal
"キーコードやマッピングされたキー列が完了するのを待つ時間(ミリ秒)。
set timeoutlen=600
"編集結果非保存のバッファから、新しいバッファを開くときに警告を出さない。
set hidden
"ヒストリの保存数
set history=50
"日本語の行の連結時には空白を入力しない。
set formatoptions+=mM
"Visual blockモードでフリーカーソルを有効にする。
set virtualedit=block
"カーソルキーで行末／行頭の移動可能に設定。
set whichwrap=b,s,[,],<,>
"バックスペースでインデントや改行を削除できるようにする。
set backspace=indent,eol,start
"□や○の文字があってもカーソル位置がずれないようにする。
if exists('&ambiwidth')
  set ambiwidth=double
endif
"コマンドライン補完するときに強化されたものを使う。
set wildmenu
set wildignore=*.bak,*.jpg,*.gif,*.png
set wildmode=list
"マウスを有効にする。
if has('mouse')
  set mouse=a
endif

" pathogen "
call pathogen#runtime_append_all_bundles()

"pluginを使用可能にする
" filetype plugin on

"Vundler
filetype off
set rtp+=~/dotfiles/vimfiles/vundle.git/
call vundle#rc()
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/'

filetype indent plugin on


"kaoriya vimrc, gvimrcを読まない
"let plugin_cmdex_disable = 1

"----------------------------------------
" 表示設定
"----------------------------------------
"gvimの色テーマは.gvimrcで指定する。
colorscheme spring
highlight Folded guifg=#f1f3e8 guibg=#444444
highlight Pmenu guibg=#84A7C1
"スプラッシュ(起動時のメッセージ)を表示しない。
"set shortmess+=I
" ハイライトを有効にする。
if &t_Co > 2 || has('gui_running')
  syntax on
endif
"エラー時の音とビジュアルベルの抑制。
"gvimの場合は.gvimrcで設定する
set noerrorbells
set novisualbell
set nostartofline
set visualbell t_vb=
"マクロ実行中などの画面再描画を行わない。
set lazyredraw
set autoread
set linespace=0
"Windowsでディレクトリパスの区切り文字表示に / を使えるようにする
set shellslash
"行番号表示
set number
set numberwidth=5
set report=0
set ruler
set scrolloff=10
"括弧の対応表示時間
set showmatch matchtime=1
"タブを設定
"set ts=4 sw=4 sts=4
"自動的にインデントする (noautoindent:インデントしない)
set autoindent
"Cインデントの設定
set cinoptions+=:0
"タイトルを表示
set title
"コマンドラインの高さ (gvimはgvimrcで指定)
set cmdheight=2
set laststatus=2
"コマンドをステータス行に表示
set showcmd
"画面最後の行をできる限り表示する。
set display=lastline
"Tab、行末の半角スペースを明示的に表示する。
"set list
"set listchars=tab:^\ ,trail:~
"ステータスラインに文字コード等表示
"iconvが使用可能の場合、カーソル上の文字コードをエンコードに応じた表示にするGetB()を使用。
if has('iconv')
  set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=[0x%{GetB()}]\ (%v,%l)/%L%8P\
else
  set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=\ (%v,%l)/%L%8P\
endif

""""""""""""""""""""""""""""""
"GetB() : カーソル上の文字コードをエンコードに応じた表示にする
""""""""""""""""""""""""""""""
function! GetB()
  let c = matchstr(getline('.'), '.', col('.') - 1)
  let c = iconv(c, &enc, &fenc)
  return s:String2Hex(c)
endfunction
" :help eval-examples
" The function Nr2Hex() returns the Hex string of a number.
function! s:Nr2Hex(nr)
  let n = a:nr
  let r = ''
  while n
    let r = '0123456789ABCDEF'[n % 16] . r
    let n = n / 16
  endwhile
  return r
endfunc
" The function String2Hex() converts each character in a string to a two
" character Hex string.
function! s:String2Hex(str)
  let out = ''
  let ix = 0
  while ix < strlen(a:str)
    let out = out . s:Nr2Hex(char2nr(a:str[ix]))
    let ix = ix + 1
  endwhile
  return out
endfunc

"----------------------------------------
" 検索
"----------------------------------------
" 検索の時に大文字小文字を区別しない。
" 大文字小文字の両方が含まれている場合は大文字小文字を区別。
set ignorecase
set smartcase
"検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
"インクリメンタルサーチ
set incsearch
"検索文字の強調表示
set hlsearch
nmap <silent> <Esc><Esc> :nohlsearch<CR><Esc>
"w,bの移動で認識する文字
"set iskeyword=a-z,A-Z,48-57,_,.,-,>
set iskeyword=@,48-57,_,192-255,-
"vimgrep をデフォルトのgrepとする場合internal
set grepprg=internal
"diffの設定
if has('win32') || has('win64')
  set diffexpr=MyDiff()
  function! MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let eq = ''
    if $VIMRUNTIME =~ ' '
      if &sh =~ '\<cmd'
        let cmd = '""' . $VIMRUNTIME . '\diff"'
        let eq = '"'
      else
        let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
      endif
    else
      let cmd = $VIMRUNTIME . '\diff'
    endif
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
  endfunction
endif

" Text formatting/Layout
set completeopt=
set expandtab
set formatoptions=rq
set ignorecase
set infercase
set wrap
set shiftround
set smartcase
set shiftwidth=2
set softtabstop=2
set tabstop=2
set smarttab

" Foldings
set nofoldenable
"set foldmarker={,}
set foldmethod=indent
set foldnestmax=10
set foldlevel=1
"set foldopen=block,hor,mark,percent,quickfix,tag

" Japanese
set enc=utf-8
set fenc=utf-8
set fileencodings=utf-8,iso-2022-jp,enc-jp,cp932
if has('multi_byte_ime')||has('xim')
  "change cursor color when jp mode
  highlight Cursor guibg=Green guifg=NONE 
  highlight CursorIM guibg=Purple guifg=NONE
endif
set iminsert=0
set imsearch=0

"現バッファの差分表示(変更箇所の表示)。
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
"ファイルまたはバッファ番号を指定して差分表示。#なら裏バッファと比較
command! -nargs=? -complete=file Diff if '<args>'=='' | browse vertical diffsplit|else| vertical diffsplit <args>|endif
"パッチコマンド
set patchexpr=MyPatch()
function! MyPatch()
   :call system($VIM."\\'.'patch -o " . v:fname_out . " " . v:fname_in . " < " . v:fname_diff)
endfunction

"----------------------------------------
" ノーマルモード
"----------------------------------------
"ヘルプ検索
nnoremap <F1> K
"現在開いているvimスクリプトファイルを実行。
nnoremap <F8> :source %<CR>
"強制全保存終了を無効化。
nnoremap ZZ <Nop>
"カーソルをj k では表示行で移動する。物理行移動は<C-n>,<C-p>
"キーボードマクロには物理行移動を推奨。
"h l は行末、行頭を超えることが可能に設定(whichwrap)
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
nnoremap J <C-d>
nnoremap K <C-u>
map! <C-a> <Home>
map! <C-e> <End>
inoremap <C-d> <Delete>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
nnoremap h <Left>
nnoremap l <Right>
"l を <Right>に置き換えても、折りたたみを l で開くことができるようにする。
if has('folding')
  nnoremap <expr> l foldlevel(line('.')) ? "\<Right>zo" : "\<Right>"
endif

" copy whole document
nnoremap yY ggyG

" insert oneline after cursor with normal mode
nnoremap O :<C-u>call append(expand('.'), '')<Cr>j

" noremap! uu <Esc>


" insert ruby tag for Hatena Diary
inoremap <D-r> >\|ruby\|<CR>\|\|<<ESC><UP><HOME>

" move between buffers
nnoremap H :bp<CR>
nnoremap L :bn<CR>

" cursor movements
let MyMoveWord_enable_wb = 1
let MyMoveWord_enable_WBE = 1

"== work like TextMate ==
inoremap <D-CR> <C-O>o
inoremap <silent> <C-l> <Space>=><Space>
inoremap <silent> <C-k> ->
"inoremap <silent> <C-u> =
"inoremap <silent> <C-u>u -
" tab shift toggle
nmap <D-]> >>
nmap <D-[> <<
vnoremap < <gv
vnoremap > >gv
" comma toggle
nmap <D-/> ,c<Space>
imap <D-/> <C-o>,c<Space>
vmap <D-/> ,c<Space>gv

" window splitting
nmap <Leader>v :vsplit<CR> <C-w><C-w>
nmap <Leader>s :split<CR> <C-w><C-w>
nmap <Leader>w <C-w><C-w>_

" Split window adjustment
nnoremap <C-w>h <C-w>h:call <SID>good_width()<CR>
nnoremap <C-w>l <C-w>l:call <SID>good_width()<CR>
nnoremap <C-w>H <C-w>H:call <SID>good_width()<CR>
nnoremap <C-w>L <C-w>L:call <SID>good_width()<CR>
function! s:good_width()
    if  winwidth(0) < 84
        vertical resize 84
    endif
endfunction

autocmd Filetype help nnoremap <buffer> q <C-w>c

"imap <silent> <C-D><C-A> <C-R>=strftime("%e %b %Y")<CR>
"imap <silent> <C-T><C-I> <C-R>=strftime("%l:%M %p")<CR>
"imap <silent> <C-C><C-A> <C-R>=string(eval(input("Calculate: ")))<CR>

"----------------------------------------
" 挿入モード
"----------------------------------------
"----------------------------------------
" ビジュアルモード
"----------------------------------------

"----------------------------------------
" コマンドモード
"----------------------------------------

"----------------------------------------
" Vimスクリプト
"----------------------------------------
""""""""""""""""""""""""""""""
"ファイルを開いたら前回のカーソル位置へ移動
""""""""""""""""""""""""""""""
augroup vimrcEx
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line('$') |
    \   exe "normal! g`\"" |
    \ endif
augroup END

""""""""""""""""""""""""""""""
"挿入モード時、ステータスラインのカラー変更
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  syntax on
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif
let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

""""""""""""""""""""""""""""""
"全角スペースを表示
""""""""""""""""""""""""""""""
if has('syntax')
  "コメント以外で全角スペースを指定しているので、scriptencodingと、
  "このファイルのエンコードが一致するよう注意！
  "強調表示されない場合、ここでscriptencodingを指定するとうまくいく事があります。
  "scriptencoding cp932
  syntax on
  function! ActivateInvisibleIndicator()
    highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
    "全角スペースを明示的に表示する。
    silent! match ZenkakuSpace /　/
  endfunction
  augroup InvisibleIndicator
    autocmd!
    autocmd VimEnter,BufEnter * call ActivateInvisibleIndicator()
  augroup END
endif

""""""""""""""""""""""""""""""
"grep,tagsのためカレントディレクトリをファイルと同じディレクトリに移動する。
""""""""""""""""""""""""""""""
"if exists('+autochdir')
"  "autochdirがある場合カレントディレクトリを移動
"  set autochdir
"else
"  "autochdirが存在しないが、カレントディレクトリを移動したい場合
"  au BufEnter * execute ":silent! cd " . expand("%:p:h")
"endif

" pdf view
autocmd BufReadPre *.pdf set ro nowrap
autocmd BufReadPost *.pdf silent %!pdftotext "%" -nopgbrk -layout -q -eol unix -
autocmd BufWritePost *.pdf silent !rm -rf ~/PDF/%
autocmd BufWritePost *.pdf silent !lp -s -d pdffg "%"
autocmd BufWritePost *.pdf silent !until [ -e ~/PDF/% ]; do sleep 1; done
autocmd BufWritePost *.pdf silent !mv ~/PDF/% %:p:h


"----------------------------------------
" 各種プラグイン設定
"----------------------------------------
" Migemo
if has('migemo')
  set migemo
  set migemodict=/usr/local/share/migemo/utf-8/migemo-dict
endif

" skk.vim
"let skk_jisyo = '~/.skk
"let skk_large_jisyo = '~/Documents/dic/SKK-JISYO.L'
"let skk_show_annotation = 1
"runtime skk.vim

" Unite
let g:unite_enable_start_insert=1
let mapleader=","
"nnoremap <silent> <Leader>r :<C-u>Unite file_mru<CR>
nnoremap <silent> <Leader>b :<C-u>Unite buffer<CR>
nnoremap <silent> <Leader>t :<C-u>Unite -input=**/ file<CR>
"nnoremap <silent> <D-t> :<C-u>Unite -input=**/ file<CR> #it open library
"files also..
nnoremap <silent> <D-t> :<C-u>Unite file<CR>


"" FuzzyFinder
""let g:fuf_modesDisable=[]
""let g:fuf_ignore="*.log"
""let g:fuf_matching_limit=70
""let g:fuf_keyOpenSplit = '<C-k>'
""let g:fuf_keyOpenVsplit = '<C-l>'
""let g:fuf_keyOpenTabpage = '<C-j>'

"nnoremap <leader>t :FufFile **/<CR>
"nnoremap <leader>b :FufBuffer<CR>
"nnoremap <leader>r :FufMruFile<CR>
"nnoremap <leader>d :FufDir<CR>
"nnoremap <leader>e :FufCoverageFile<CR>
""
""let g:VimShell_EnableInteractive = 1

"nnoremap <unique> <silent> <C-S> :FufBuffer!<CR>
"nnoremap <unique> <silent> eff :FufFile!<CR>
"nnoremap <silent> efb :FufBuffer!<CR>
"nnoremap <silent> efe :FufFileWithCurrentBuffer!<CR>
"nnoremap <silent> efm :FufMruFile!<CR>
"nnoremap <silent> efj :FufMruFileWithCurrentPwd!<CR>
"autocmd FileType fuf nmap <C-c> <ESC>
"let g:fuf_splitPathMatching = ' '
"let g:fuf_patternSeparator = ' '
"let g:fuf_modesDisable = ['mrucmd']
"let g:fuf_mrufile_exclude = '\v\~$|\.bak$|\.swp|\.howm$'
"let g:fuf_mrufile_maxItem = 10000
"let g:fuf_enumeratingLimit = 20
"let g:fuf_previewHeight = 20

" Vimfiler
let g:vimfiler_as_default_explorer = 1

nnoremap <unique> <silent> <C-A> :VimFiler<CR>

" NERDTree
"nnoremap <unique> <silent> <C-A> :NERDTreeToggle<CR>
"map <leader>, :NERDTreeToggle<CR>
"map \( i(<Esc>ea)<Esc>
"map \{ i{<Esc>ea}<Esc>


"neocomplcache
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
    

" Changelog
let g:changelog_timeformat = "%Y-%m-%d"
let g:changelog_username = "kyoendo"


" Processing doc
"let processing_doc_path="/Applications/Processing.app/Contents/Resources/Java/reference"

" Move window position {{{
nmap <Space><C-n> <Plug>swap_window_next
nmap <Space><C-p> <Plug>swap_window_prev
nmap <Space><C-j> <Plug>swap_window_j
nmap <Space><C-k> <Plug>swap_window_k
nmap <Space><C-h> <Plug>swap_window_h
nmap <Space><C-l> <Plug>swap_window_l
" nmap <Space><C-t> <Plug>swap_window_t
" nmap <Space><C-b> <Plug>swap_window_b

nnoremap <silent> <Plug>swap_window_next :<C-u>call <SID>swap_window_count(v:count1)<CR>
nnoremap <silent> <Plug>swap_window_prev :<C-u>call <SID>swap_window_count(-v:count1)<CR>
nnoremap <silent> <Plug>swap_window_j :<C-u>call <SID>swap_window_dir(v:count1, 'j')<CR>
nnoremap <silent> <Plug>swap_window_k :<C-u>call <SID>swap_window_dir(v:count1, 'k')<CR>
nnoremap <silent> <Plug>swap_window_h :<C-u>call <SID>swap_window_dir(v:count1, 'h')<CR>
nnoremap <silent> <Plug>swap_window_l :<C-u>call <SID>swap_window_dir(v:count1, 'l')<CR>
nnoremap <silent> <Plug>swap_window_t :<C-u>call <SID>swap_window_dir(v:count1, 't')<CR>
nnoremap <silent> <Plug>swap_window_b :<C-u>call <SID>swap_window_dir(v:count1, 'b')<CR>

function! s:modulo(n, m) "{{{
  let d = a:n * a:m < 0 ? 1 : 0
  return a:n + (-(a:n + (0 < a:m ? d : -d)) / a:m + d) * a:m
endfunction "}}}

function! s:swap_window_count(n) "{{{
  let curwin = winnr()
  let target = s:modulo(curwin + a:n - 1, winnr('$')) + 1
  call s:swap_window(curwin, target)
endfunction "}}}

function! s:swap_window_dir(n, dir) "{{{
  let curwin = winnr()
  execute a:n 'wincmd' a:dir
  let targetwin = winnr()
  wincmd p
  call s:swap_window(curwin, targetwin)
endfunction "}}}

function! s:swap_window(curwin, targetwin) "{{{
  let curbuf = winbufnr(a:curwin)
  let targetbuf = winbufnr(a:targetwin)

  if curbuf == targetbuf
    " TODO: Swap also same buffer!
  else
    execute 'hide' targetbuf . 'buffer'
    execute a:targetwin 'wincmd w'
    execute curbuf 'buffer'
  endif
endfunction "}}}

" }}}

