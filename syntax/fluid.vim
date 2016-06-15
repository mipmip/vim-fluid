" Vim syntax file
" Language:	Fluid Templates
" Description:        html5 (and html4), and js, and css and (typo3) fluid indenter
" Changed By:         Pim Snel <pim@lingewoud.nl>
" Last Change:        15 Jun 2016
"   Added the fluid f: pattern
"   Added fluid non-indenting tags
" Filenames:    *.fluid
" Usage:  As fluid templates almost always use .html set a modeline on top of
          your template.
" URL:		https://github.com/mipmip/vim-fluid

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
  finish
endif
  let main_syntax = 'fluid'
endif

syn case ignore

runtime! syntax/html.vim
unlet b:current_syntax



