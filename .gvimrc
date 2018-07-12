" UI {
    set guicursor=a:block-blinkon0
    set guioptions=

    highlight Cursor guifg=black

    " Fonts {
        if LINUX()
            set guifont=Source\ Code\ Pro\ 14
            set guifontwide=YouYuan\ 14
        elseif OSX()
            set guifont=Source\ Code\ Pro:h14
            set guifontwide=YouYuan:h14
        elseif WINDOWS()
            set guifont=Source_Code_Pro:h14
            set guifontwide=YouYuan:h14
        endif
    " }
" }
