" UI {
    set guicursor=a:block-blinkon0
    set guioptions=

    highlight Cursor guifg=black


    if filereadable(expand('~/.vim/colors/distinguished.vim'))
        colorscheme molokai
    endif

    " Fonts {
        if LINUX()
            set guifont=Source\ Code\ Pro\ 12
            set guifontwide=YouYuan\ 12
        elseif OSX()
            set guifont=Source\ Code\ Pro:h12
            set guifontwide=YouYuan:h12
        elseif WINDOWS()
            set guifont=Source_Code_Pro:h12
            set guifontwide=YouYuan:h12
        endif
    " }
" }
