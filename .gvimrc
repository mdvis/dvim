" UI {
    set guicursor=a:block-blinkon0
    set lines=999 columns=999
    set guioptions=

    highlight Cursor guifg=black

    " Indent {
        let g:indent_guides_guide_size= 1
        let g:indent_guides_auto_colors = 0
        let g:indent_guides_enable_on_vim_startup = 1
        autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#333333
        autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#000000
    " }

    if filereadable(expand('~/.vim/colors/distinguished.vim'))
        colorscheme molokai
    endif

    " Fonts {
        if LINUX()
            set guifont=Source\ Code\ Pro\ 12
            set guifontwide=YouYuan\ 12
        elseif OSX()
            set guifont=Source\ Code\ Pro:h16
            set guifontwide=YouYuan:h16
        elseif WINDOWS()
            set guifont=Source_Code_Pro:h12
            set guifontwide=YouYuan:h12
        endif
    " }
" }
