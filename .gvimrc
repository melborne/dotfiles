"scriptencoding cp932
"----------------------------------------
" システム設定
"----------------------------------------
"エラー時の音とビジュアルベルの抑制。
set noerrorbells
set novisualbell
set visualbell t_vb=

if has('multi_byte_ime') || has('xim')
  set iminsert=0 imsearch=0
  if has('xim') && has('GUI_GTK')
    " XIMの入力開始キー
    "set imactivatekey=C-space
  endif
endif

"----------------------------------------
" 表示設定
"----------------------------------------
" 英語メニュー
set langmenu=none
" ツールバーを非表示
set guioptions-=T
" コマンドラインの高さ
set cmdheight=2

" カラー設定:
"colorscheme blackboard
if  has('gui_running')
    colorscheme rdark
    highlight Pmenu guibg=#84A7C1
else
    colorscheme inkpot
    highlight Pmenu guibg=#84A7C1
end
set transparency=10

" フォント設定
set linespace=1
if has('win32')
  set guifont=MS_Gothic:h11:cSHIFTJIS
  set guifontwide=MS_Gothic:h11:cSHIFTJIS
  set linespace=0
elseif has('mac')
  set guifont=Monaco:h15
elseif has('xfontset')
  set guifontset=a14,r14,k14
  set linespace=0
else
endif

"change cursor color on ime
hi CursorIM  guifg=black  guibg=red  gui=NONE  ctermfg=black  ctermbg=white  cterm=reverse
" maintain ime status in mode
set noimdisableactivate

"winpos 340 120
"set lines=45
"set columns=90
"set autochdir

"メッセージの日本語化
"let $LANG='ja'

""""""""""""""""""""""""""""""
" Window位置の保存と復帰
""""""""""""""""""""""""""""""
if 1 && has('gui_running')
  if has('unix')
    let s:infofile = '~/.vim/.vimpos'
  else
    let s:infofile = '~/_vimpos'
  endif

  function! s:WinPosSizeSave(filename)
    let saved_reg = @a
    redir @a
    winpos
    redir END
    let px = substitute(@a, '.*X \(\d\+\).*', '\1', '') + 0
    let py = substitute(@a, '.*Y \(\d\+\).*', '\1', '') + 0
    execute 'redir! >'.a:filename
    if px > 0 && py > 0
      echo 'winpos '.px.' '.py
    endif
    echo 'set lines='.&lines.' columns='.&columns
    redir END
    let @a = saved_reg
  endfunction

  augroup WinPosSizeSaver
  autocmd!
  augroup END
  execute 'autocmd WinPosSizeSaver VimLeave * call s:WinPosSizeSave("'.s:infofile.'")'
  if filereadable(expand(s:infofile))
    execute 'source '.s:infofile
  endif
  unlet s:infofile
endif

"----------------------------------------
" メニューアイテム作成
"----------------------------------------
"silent! aunmenu &File.Save
"silent! aunmenu &File.保存(&S)
"silent! aunmenu &File.差分表示(&D)\.\.\.
"
"let message_revert="再読込しますか?"
"amenu <silent> 10.330 &File.再読込(&U)<Tab>:e!  :if confirm(message_revert, "&Yes\n&No")==1<Bar> e! <Bar> endif<CR>
"amenu <silent> 10.331 &File.バッファ削除(&K)<Tab>:bd  :confirm bd<CR>
"amenu <silent> 10.340 &File.保存(&W)<Tab>:w  :if expand('%') == ''<Bar>browse confirm w<Bar>else<Bar>confirm w<Bar>endif<CR>
"amenu <silent> 10.341 &File.更新時保存(&S)<Tab>:update  :if expand('%') == ''<Bar>browse confirm w<Bar>else<Bar>confirm update<Bar>endif<CR>
"amenu <silent> 10.400 &File.現バッファ差分表示(&D)<Tab>:DiffOrig  :DiffOrig<CR>
"amenu <silent> 10.401 &File.裏バッファと差分表示(&D)<Tab>:Diff\ #  :Diff #<CR>
"amenu <silent> 10.402 &File.差分表示(&D)<Tab>:Diff  :browse vertical diffsplit<CR>

" vim:set et ts=2 sts=2 sw=2

" tab
set showtabline=1 
let mapleader=","

"    nnoremap H :tabNext<CR>
"    nnoremap L :tabnext<CR>

"macm File.New\ Window                       key=<D-n> action=newWindow:
macm File.New\ Tab                          key=<D-C-t>
"macm File.Open\.\.\.                        key=<D-o> action=fileOpen:
"macm File.Open\ Tab\.\.\.                   key=<D-T>
"macm File.Open\ Recent                      action=recentFilesDummy:
"macm File.Close\ Window                     key=<D-W>
"macm File.Close                             key=<D-w> action=performClose:
"macm File.Save                              key=<D-s>
"macm File.Save\ All                         key=<D-M-s> alt=YES
"macm File.Save\ As\.\.\.                    key=<D-S>
"macm File.Print                             key=<D-p>

"macm Edit.Undo                              key=<D-z> action=undo:
"macm Edit.Redo                              key=<D-Z> action=redo:
"macm Edit.Cut                               key=<D-x> action=cut:
"macm Edit.Copy                              key=<D-c> action=copy:
"macm Edit.Paste                             key=<D-v> action=paste:
"macm Edit.Select\ All                       key=<D-a> action=selectAll:
"macm Edit.Find.Find\.\.\.                   key=<D-f>
"macm Edit.Find.Find\ Next                   key=<D-g> action=findNext:
"macm Edit.Find.Find\ Previous               key=<D-G> action=findPrevious:
"macm Edit.Find.Use\ Selection\ for\ Find    key=<D-e>
"macm Edit.Special\ Characters\.\.\.         key=<D-M-t>
"macm Edit.Font.Show\ Fonts                  action=orderFrontFontPanel:
"macm Edit.Font.Bigger                       key=<D-=> action=fontSizeUp:
"macm Edit.Font.Smaller                      key=<D--> action=fontSizeDown:
"macm Edit.Special\ Characters\.\.\.         action=orderFrontCharacterPalette:

macm Tools.Spelling.To\ Next\ error         key=<D-C-;>
macm Tools.Spelling.Suggest\ Corrections    key=<D-C-:>
"macm Tools.Make                             key=<D-b>
"macm Tools.List\ Errors                     key=<D-l>
"macm Tools.List\ Messages                   key=<D-L>
"macm Tools.Next\ Error                      key=<D-C-Right>
"macm Tools.Previous\ Error                  key=<D-C-Left>
"macm Tools.Older\ List                      key=<D-C-Up>
"macm Tools.Newer\ List                      key=<D-C-Down>

"macm Window.Minimize        key=<D-m>       action=performMiniaturize:
"macm Window.Minimize\ All   key=<D-M-m>     action=miniaturizeAll:  alt=YES
"macm Window.Zoom            key=<D-C-z>     action=performZoom:
"macm Window.Zoom\ All       key=<D-M-C-z>   action=zoomAll:         alt=YES
"macm Window.Toggle\ Full\ Screen\ Mode  key=<D-F>
"macm Window.Select\ Next\ Tab           key=<D-}>
"macm Window.Select\ Previous\ Tab       key=<D-{>
"macm Window.Bring\ All\ To\ Front       action=arrangeInFront:

"macm Help.MacVim\ Help                  key=<D-?>
"macm Help.MacVim\ Website               action=openWebsite:

map <D-1> :tabn 1<CR>
map <D-2> :tabn 2<CR>
map <D-3> :tabn 3<CR>
map <D-4> :tabn 4<CR>
map <D-5> :tabn 5<CR>
map <D-6> :tabn 6<CR>
map <D-7> :tabn 7<CR>
"map <D-8> :tabn 8<CR>
"map <D-9> :tabn 9<CR>

map! <D-1> <C-O>:tabn 1<CR>
map! <D-2> <C-O>:tabn 2<CR>
map! <D-3> <C-O>:tabn 3<CR>
map! <D-4> <C-O>:tabn 4<CR>
map! <D-5> <C-O>:tabn 5<CR>
map! <D-6> <C-O>:tabn 6<CR>
map! <D-7> <C-O>:tabn 7<CR>
"map! <D-8> <C-O>:tabn 8<CR>
"map! <D-9> <C-O>:tabn 9<CR>

set clipboard+=unnamed

nmap + :set transparency+=5<CR>
nmap ; :set transparency-=5<CR>

