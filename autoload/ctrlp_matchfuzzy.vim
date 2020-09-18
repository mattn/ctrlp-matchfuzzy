function s:esc(s) abort
  return substitute(a:s, '.', '\0[^\0]\\{-}', 'g')
endfunction

function! ctrlp_matchfuzzy#matcher(items, str, limit, mmode, ispath, crfile, regex) abort
  call clearmatches()
  call matchadd('CtrlPMatch', '\c' .. s:esc(a:str))
  call matchadd('CtrlPLinePre', '^>')
  return matchfuzzy(a:items, a:str)
endfunction


