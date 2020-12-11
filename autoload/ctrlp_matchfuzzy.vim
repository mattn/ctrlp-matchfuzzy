function s:esc(s) abort
  return substitute(a:s, '.', '\0[^\0]\\{-}', 'g')
endfunction

function! ctrlp_matchfuzzy#matcher(items, str, limit, mmode, ispath, crfile, regex) abort
  call clearmatches()
  if empty(a:str)
    return copy(a:items)
  endif
  if a:regex
    call matchadd('CtrlPMatch', a:str)
    call matchadd('CtrlPLinePre', '^>')
    return filter(copy(a:items), 'v:val =~ a:str')
  else
    call matchadd('CtrlPMatch', '\c' .. s:esc(a:str))
    call matchadd('CtrlPLinePre', '^>')
    return matchfuzzy(a:items, a:str)
  endif
endfunction


