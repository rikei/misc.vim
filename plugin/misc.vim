"============================================================================
"File:        misc.vim
"Description: Vim plugin for misc
"============================================================================

if exists('g:loaded_misc_plugin') || &compatible
    finish
endif
let g:loaded_misc_plugin = 1

map <F11> :call ToggleFullScreen()<CR>
map <F12> :call ToggleVimTopMostMode()<CR>

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
" vim: set sw=4 sts=4 et fdm=marker:
