function s:esc(s) abort
  return '\c' . substitute(tolower(a:s), '.', '\0[^\0]\\{-}', 'g')
endfunction

let s:timer = 0

function! ctrlp_matchfuzzy#matcher(items, str, limit, mmode, ispath, crfile, regex) abort
  if empty(a:str)
    call clearmatches()
    return a:items[:&lines]
  endif

  let l:str = a:regex ? a:str : s:esc(a:str)
  call timer_stop(s:timer)
  let s:timer = timer_start(10, {t ->
  \ [clearmatches(), matchadd('CtrlPMatch', l:str), hlexists('CtrlPLinePre') ? matchadd('CtrlPLinePre', '^>') : '', execute('redraw')]
  \}, {'repeat': 0})

  if a:regex
    return filter(a:items, 'v:val =~ a:str')
  else
    return matchfuzzy(a:items, a:str, {'limit': &lines})
  endif
endfunction
