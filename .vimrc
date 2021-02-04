" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker:
scriptencoding utf-8

" Custom method {
    if filereadable(expand('~/.vimrc.custom'))
        source ~/.vimrc.custom
    endif
" }

" Vim-plug {
    if filereadable(expand('~/.vimrc.plugins'))
        source ~/.vimrc.plugins
    endif
" }

" Custom method {
    if filereadable(expand('~/.vimrc.conf'))
        source ~/.vimrc.conf
    endif
" }

" Custom method {
    if filereadable(expand('~/.vimrc.maps'))
        source ~/.vimrc.maps
    endif
" }


