" UI {
    set guicursor=a:block-blinkon0
    set guioptions=

    highlight Cursor guifg=black


    if filereadable(expand('~/.vim/colors/distinguished.vim'))
        colorscheme molokai
    endif

    " Fonts {
        if LINUX()
            set guifont=Source\ Code\ Pro\ 16
            set guifontwide=YouYuan\ 16
        elseif OSX()
            set guifont=Source\ Code\ Pro:h16
            set guifontwide=YouYuan:h16
        elseif WINDOWS()
            set guifont=Source_Code_Pro:h16
            set guifontwide=YouYuan:h16
        endif
    " }
" }
