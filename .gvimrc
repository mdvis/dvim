" UI {
    set guicursor=a:block-blinkon0
    set lines=999 columns=999
    "set guioptions=

    highlight Cursor guifg=black


    if filereadable(expand('~/.vim/colors/distinguished.vim'))
        colorscheme molokai
    endif

    " Fonts {
        if LINUX()
            set guifont=Source\ Code\ Pro\ 10
            set guifontwide=YouYuan\ 10
        elseif OSX()
            set guifont=Source\ Code\ Pro:h14
            set guifontwide=YouYuan:h14
        elseif WINDOWS()
            set guifont=Source_Code_Pro:h10
            set guifontwide=YouYuan:h10
        endif
    " }
" }
