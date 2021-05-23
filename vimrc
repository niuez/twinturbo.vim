let s:b1 = "#3867b1"
let s:b2 = "#3c93f8"
let s:b3 = "#22BDB9"
let s:b4 = "#2dfbf5"
let s:r1 = "#F22294"
let s:g1 = "#B2F227"
let s:black = "#2F2F3E"
let s:fg = s:b1
"let s:fg = "#a4a4a4"
let s:bg = "#eeeeee"
let s:none = "NONE"
let s:bold = "bold"

function! s:h(group, fg, bg, attr)
  if a:attr != ""
    exec "hi " . a:group . " guifg=" . a:fg . " guibg=" . a:bg . " gui=" . a:attr
  else
    exec "hi " . a:group . " guifg=" . a:fg . " guibg=" . a:bg . " gui=" . s:none
  endif
endfun


function! SetStatusLine()
  if mode() =~ 'i'
    let c = 1
    let mode_name = 'INSERT'
  elseif mode() =~ 'n'
    let c = 2
    let mode_name = 'NORMAL'
  elseif mode() =~ 'R'
    let c = 3
    let mode_name = 'REPLACE'
  elseif mode() =~ 'c'
    let c = 4
    let mode_name = 'COMMAND'
  else
    let c = 5
    let mode_name = 'VISUAL'
  endif

  return "%#UserStatusLineLEdge#  %#UserStatusLineLeft#  " . mode_name . " \ue0bb  %F%<%m%r %#UserStatusLineLtoI#\ue0bc%#UserStatusLineInnerL#"
        \ . "   %#UserStatusLineB2BG#\ue0b9%#UserStatusLineG1#\ue0b9%#UserStatusLineInnerL#   "
        \ . "%#UserStatusLineILtoIR#\ue0bc\ue0bb%#UserStatusLineR1#\ue0bb%#UserStatusLineB2FG#\ue0bb"
        \ . "%#UserStatusLineILtoIR#\ue0bb"
        \ . "%#UserStatusLineInnerR#%=%#UserStatusLineItoR#\ue0bc   %#UserStatusLineRight#%{&ft}  \ue0bb  %c:%l  %#UserStatusLineREdge#  "
endfunction

call s:h("UserStatusLineLEdge", s:none, s:black, s:bold)
call s:h("UserStatusLineLeft", s:black, s:r1, s:bold)
call s:h("UserStatusLineLtoI", s:r1, s:black, s:bold)
call s:h("UserStatusLineInnerL", s:bg, s:black, s:bold)
call s:h("UserStatusLineILtoIR", s:black, s:bg, s:bold)
call s:h("UserStatusLineInnerR", s:fg, s:bg, s:bold)
call s:h("UserStatusLineItoR", s:bg, s:g1, s:bold)
call s:h("UserStatusLineRight", s:black, s:g1, s:bold)
call s:h("UserStatusLineREdge", s:bg, s:black, s:bold)
call s:h("UserStatusLineR1", s:r1, s:bg, s:bold)
call s:h("UserStatusLineG1", s:g1, s:black, s:bold)
call s:h("UserStatusLineB2BG", s:b2, s:black, s:bold)
call s:h("UserStatusLineB2FG", s:b2, s:bg, s:bold)
 
set statusline=%!SetStatusLine()

function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

function! SynGroup()                                                            
    let l:s = synID(line('.'), col('.'), 1)                                       
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

nmap sc :call SynGroup()<CR>
nmap sr :colorscheme twinturbo<CR>
