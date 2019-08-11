" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker:

" Environment {
    " Basics {
        set nocompatible
    " }
    " Identify platform {
        silent function! OSX()
            return has('macunix')
        endfunction

        silent function! LINUX()
            return has('unix') && !has('macunix') && !has('win32unix')
        endfunction

        silent function! WINDOWS()
            return  (has('win32') || has('win64'))
        endfunction
    " }
" }

" General {
    " File {
        filetype plugin indent on
        syntax on
        set mouse= " a
        set mousehide
    " }
    set nospell
    " set tildeop                 "~motion
    set iskeyword=@,%,#,.
    " set virtualedit=onemore     " Allow for cursor beyond last character
    set clipboard=unnamed
    set shortmess+=filmnrxoOtT    " Abbrev. of messages (avoids 'hit enter')
    " Better Unix / Windows compatibility
    set viewoptions=folds,options,cursor,unix,slash
" }

" UI {
    set shortmess=atI
    set showmode       " Display the current mode
    set showcmd
    set cursorline     " Highlight current line
    set cursorcolumn   " Highlight current column
    set colorcolumn=80
    set listchars=tab:>-,trail:-
    set list
    " Behavior {
        set expandtab           " Tabs are spaces, not tabs
        set tabstop=2           " An indentation every four columns
        set shiftwidth=2
        set softtabstop=2               " Let backspace delete indent
        set backspace=indent,eol,start  " Backspace for dummies
        set whichwrap=b,s,<,>,[,]       " Backspace and cursor keys wrap too
        set formatoptions+=mM
        set formatoptions-=c
        set foldmethod=marker
        set foldmarker={,}
        set scrolljump=5
        set nofoldenable
        set textwidth=80
        set foldlevel=0
        set scrolloff=3
        set cmdheight=2
        set splitbelow
        " set foldenable        " Auto fold code
        set splitright
        set autoindent          " Indent at the same level of the previous line
        set ignorecase          " Case insensitive search
        set incsearch           " Find as you type search
        set smartcase           " Case sensitive when uc present
        set showmatch           " Show matching brackets/parenthesis
        set autochdir
        set autoread
        set hlsearch
        set nowrap
        set linebreak
        set wrapmargin=2
        set sidescrolloff=8
        set number
        " set relativenumber
        set noerrorbells " no error bell
        set visualbell   " visual error bell
    " }
    set linespace=0                 " No extra spaces between rows
    set winminheight=0              " Windows can be 0 line high
    set background=dark

    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches,
                                    " then longest common part, then all.
    " Colors {
        if filereadable(expand('~/.vim/colors/gruvbox.vim'))
            let g:gruvbox_contrast_dark='hard'
            colorscheme gruvbox
        endif
    " }
" }

" Encode {
    if has('multi_byte')
        " Powershell as the primary terminal, this would be utf-8
        set termencoding=utf-8

        " set termencoding=cp850
        " Let Vim use utf-8 internally, because many scripts require this
        set encoding=utf-8
        scriptencoding utf-8
        setglobal fileencoding=utf-8

        " Windows has traditionally used cp1252, so it's probably wise to
        " fallback into cp1252 instead of eg. iso-8859-15.
        " Newer Windows files might contain utf-8 or utf-16 LE so we might
        " want to try them first.
        set fileencodings=ucs-bom,utf-8,utf-16le,cp1252,iso-8859-15
    endif
    if has('win32')
        source $VIMRUNTIME/vimrc_example.vim

        " menu error code
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim

        " console output error code
        language messages zh_CN.utf-8
    endif
" }

" Vim-plug {
    if filereadable(expand('~/.vimrc.plugins'))
        source ~/.vimrc.plugins
    endif
" }

" Custom method {
    if filereadable(expand('~/.vimrc.custom'))
        source ~/.vimrc.custom
    endif
" }

" Auto load vimrc {
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
" }

" Mappings {
    let g:mapleader = ','

    nmap <leader>sw :mksession! ~/.my.vim<CR>
    nmap <leader>sr :source ~/.my.vim<CR>
    nmap <leader>r :reg<CR>
    nmap <leader>N :noh<CR>
    nmap <leader>J :JsDoc<CR>

    nmap <leader>w :w<CR>
    nmap <leader>q :q<CR>
    nmap <leader>x :x<CR>

    nmap <leader>h <c-w>h
    nmap <leader>j <c-w>j
    nmap <leader>k <c-w>k
    nmap <leader>l <c-w>l

    nmap j gj
    nmap k gk
" }
