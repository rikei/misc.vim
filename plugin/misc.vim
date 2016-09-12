"============================================================================
"File:        misc.vim
"Description: Vim plugin for misc
"============================================================================

if exists('g:loaded_misc_plugin') || &compatible
    finish
endif
let g:loaded_misc_plugin = 1

"============================================================================
map <F11> :call ToggleFullScreen()<CR>
map <F12> :call ToggleVimTopMostMode()<CR>

command! SetTitle call MiscSetTitle()
au BufNewFile,BufRead *.{c,cpp,h} call MiscSetCEnv()
"============================================================================
if !exists('g:misc_lib_home')
	let g:misc_lib_home=$HOME.'\.vim\bundle\misc.vim\libs'
endif

let g:misc_lib_fs=g:misc_lib_home.'\gvimfullscreen.dll'
function! ToggleFullScreen()
    if has('gui_running') && has("gui_win32") && has('libcall')
        call libcall(g:misc_lib_fs, 'ToggleFullScreen', 1)
    else
        echomsg "fullscreen not support!!!"
    endif
endfunction

let g:misc_lib_tweak=g:misc_lib_home.'\vimtweak.dll'
let g:misc_opt_topmost = 0
function! ToggleVimTopMostMode()
	if g:misc_opt_topmost == 0
		let g:misc_opt_topmost = 1
	else
		let g:misc_opt_topmost = 0
	endif
    if has('gui_running') && has("gui_win32") && has('libcall')
		call libcall(g:misc_lib_tweak, 'EnableTopMost', g:misc_opt_topmost)
	else
		echomsg "topmostmode not support!!!"
	endif
endfunction

" comment leader
let b:comment_leader = ''
au FileType haskell,vhdl,ada,sql
            \ let b:comment_leader = '-- '
au FileType vim
            \ let b:comment_leader = '" '
au FileType c,cpp,java
           \ let b:comment_leader = '// '
au FileType sh,make,perl,python
            \ let b:comment_leader = '# '
au FileType tex
            \ let b:comment_leader = '% '

" set titile
func! MiscSetTitle ()
    if b:comment_leader == ''
        echomsg "unknown filetype"
        return
    endif
    let s:title=""

    " shabang
    if "sh" == &ft
        let s:title .= "#!/bin/env bash\r"
    elseif "python" ==&ft
        let s:title  = "#!/bin/env python\r"
        let s:title .= "# -*- coding: utf-8 -*-\r"
    endif

    " body
    let s:title .= b:comment_leader."==========================================================\r"
    let s:title .= b:comment_leader." File          : ".expand("%:t")."\r"
    let s:title .= b:comment_leader." Author        :\r"
    let s:title .= b:comment_leader." Description   : xxxxxx\r"
    let s:title .= b:comment_leader." Last Modified : ".strftime("%Y %b %d %X") ."\r"
    let s:title .= b:comment_leader."==========================================================\r"

    call append(0, s:title)
    exe "1s//\r/g"
endfunc

" set tags and cscope
func! MiscSetCEnv()
    if has("path_extra")
        if "" != $MISC_PATH_C
            for path in split($MISC_PATH_C, ',\| ')
                exec "set path+=".path
            endfor
        endif
    endif

    if has("emacs_tags")
        if "" != $MISC_TAGS_C
            for tag in split($MISC_TAGS_C, ',\| ')
                exec "set tags+=".tag
            endfor
        endif
    endif

    "cscope -b
    if has("cscope")
        "set csprg=/usr/cscope
        set csto=1
        set cst
        "set cscopequickfix=s-,c-,d-,i-,t-,e-
        set nocsverb

        if "" != $MISC_CSCOPE_C
            for cscope in split($MISC_CSCOPE_C, ',\| ')
                exec "cs add ".cscope
            endfor
        endif

        set csverb
    endif
endfunc
" vim: set sw=4 sts=4 et fdm=marker:
