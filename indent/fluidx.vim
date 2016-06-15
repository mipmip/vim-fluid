" Inspired by: http://github.com/kchmck/vim-coffee-script

if exists('b:did_indent')
  finish
endif

if !exists('g:fluid_indent_verbose')
  let g:fluid_indent_verbose = 1
endif

let s:indentexprs = {}

" NOTE: Javascript does not use indentexpr, but gets handled by html.vim.
"       CoffeeScript injects itself via after/indent/html.vim.
let s:pairs = {
      \ 'php': ['{php[^>]*}', '', '{/php}', 'bWn'],
      \ }

for ft in keys(s:pairs)
    silent! unlet b:did_indent
    exec 'runtime indent/'.ft.'.vim'
    let s:indentexprs[ft] = &l:indentexpr
endfor


" Load html last so it can overwrite other settings.
silent! unlet b:did_indent
runtime indent/html.vim
let s:indentexprs['html'] = &l:indentexpr

let b:did_indent = 1

func! s:AddITags(taglist) "{{{
    for itag in a:taglist
	let s:indent_tags[itag] = 1
	let s:indent_tags['/'.itag] = -1
    endfor
endfunc "}}}

call s:AddITags(['area', 'article', 'aside', 'audio', 'bdi', 'canvas',
      \ 'command', 'datalist', 'details', 'embed', 'figure', 'footer',
      \ 'header', 'group', 'keygen', 'mark', 'math', 'meter', 'nav', 'output',
      \ 'progress', 'ruby', 'section', 'svg', 'texture', 'time', 'video',
      \ 'wbr', 'text'])


" Inject our wrapper indent function.
setlocal indentexpr=GetFluidHtmlIndent(v:lnum)

function! s:handle(lnum, ft, searchpairargs)
  " See if we're inside a subblock.
  let save_cursor = getcurpos()
  exec a:lnum
  let scriptlnum = call('searchpair', a:searchpairargs)
  let prevlnum = prevnonblank(a:lnum)
  call setpos('.', save_cursor)

  " If we're in a subblock and the previous line isn't the starting tag
  " itself, use its indenting.
  if scriptlnum && scriptlnum != prevlnum
    exec 'return ' s:indentexprs[a:ft]
  endif
  return ""
endfun

function! GetFluidHtmlIndent(lnum)
  for [ft, args] in items(s:pairs)
    let r = call('s:handle', [a:lnum, ft, args])
    if type(r) == type(0)
      if g:fluid_indent_verbose
        echom "Line ".a:lnum.": using ".ft." indenting via ".s:indentexprs[ft].": ".r."."
      endif
      return r
    endif
  endfor

  " Fallback to HTML.
  if g:fluid_indent_verbose
    echom "Line ".a:lnum.": using HTML indenting via ".s:indentexprs['html']."."
  endif
  exec 'return ' s:indentexprs['html']
endfunction
