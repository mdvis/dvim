" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker:

" Environment {
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

    " Basics {
        set nocompatible        " Must be first line
    " }
" }

" Vim-plug {
    if filereadable(expand('~/.vimrc.plugins'))
        source ~/.vimrc.plugins
    endif
" }

" General {
    " File {
        filetype plugin indent on   " Automatically detect file types.
        syntax on                   " Syntax highlighting

        set mouse=a
        set mousehide
    " }

    set nospell                                     " Spell checking off
    set iskeyword -=.
    set iskeyword -=#
    set iskeyword -=-
    "set virtualedit=onemore                         " Allow for cursor beyond last character
    set shortmess+=filmnrxoOtT                      " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
" }

" UI {
    set showmode " Display the current mode
    set cursorline                  " Highlight current line
    " set cursorcolumn                " Highlight current line
    if has('statusline')
        set laststatus=2
        " set statusline=
    endif
    " Behavior {
        set backspace=indent,eol,start  " Backspace for dummies
        set whichwrap=b,s,<,>,[,]       " Backspace and cursor keys wrap too
        set formatoptions+=mM
        set foldmethod=marker
        set foldmarker={,}
        set softtabstop=4               " Let backspace delete indent
        set scrolljump=5                " Lines to scroll when cursor leaves screen
        set shiftwidth=4                " Use indents of 4 spaces
        set nofoldenable
        set textwidth=80
        " set foldenable                  " Auto fold code
        set foldlevel=0
        set scrolloff=3                 " Minimum lines to keep above and below cursor
        set splitbelow
        set splitright
        set autoindent                  " Indent at the same level of the previous line
        set ignorecase                  " Case insensitive search
        set expandtab                   " Tabs are spaces, not tabs
        set tabstop=4                   " An indentation every four columns
        set incsearch                   " Find as you type search
        set smartcase                   " Case sensitive when uc present
        set showmatch                   " Show matching brackets/parenthesis
        set hlsearch                    " Highlight search terms
        set nowrap                      " Not wrap
        set number                      " Line numbers on
    " }
    set wildmenu                    " Show list instead of just completing
    set linespace=0                 " No extra spaces between rows
    set winminheight=0              " Windows can be 0 line high
    set background=dark
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.


    " Colors {
        if filereadable(expand('~/.vim/colors/solarized.vim'))
            colorscheme solarized
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
"}

" Auto load vimrc {
    if has('autocmd')
            autocmd! bufwritepost $MYVIMRC source $MYVIMRC
    endif
" }

" Mappings {
    let g:mapleader = ','

    vnoremap <leader>y "+y
    vnoremap <leader>p "+p

    nmap <leader>1 :vertical resize 120<CR>
    nmap <leader>2 :vertical resize 25<CR>
    nmap <leader>sw :mksession! .my.vim<CR>
    nmap <leader>sr :source .my.vim<CR>
    nmap <leader>r :reg<CR>
    nmap <leader>N :noh<CR>
    nmap <leader>w :w<CR>
    nmap <leader>q :q<CR>
    nmap <leader>h <c-w>h
    nmap <leader>j <c-w>j
    nmap <leader>k <c-w>k
    nmap <leader>l <c-w>l
    nmap j gj
    nmap k gk

" }

" Plugin Config Start {
    " airline {
        let g:airline_theme='molokai'
        let g:airline_powerline_fonts=1
        let g:airline#extensions#tabline#enabled=1
        let g:airline#extensions#bufferline#enabled = 0
        let g:airline#extensions#tabline#left_sep = ' '
        let g:airline#extensions#tabline#left_alt_sep = '|'
        let g:airline#extensions#tabline#formatter = 'unique_tail'

        " unicode symbols
        if !exists('g:airline_symbols')
            let g:airline_symbols = {}
        endif
        let g:airline_left_sep = '▶'
        let g:airline_right_sep = '◀'
        let g:airline_left_alt_sep = '❯'
        let g:airline_right_alt_sep = '❮'
        let g:airline_symbols.paste = '∥'
        let g:airline_symbols.spell = 'Ꞩ'
        let g:airline_symbols.crypt = '🔒'
        let g:airline_symbols.linenr = '☰'
        let g:airline_symbols.branch = '⎇'
        let g:airline_symbols.maxlinenr = '㏑'
        let g:airline_symbols.notexists = '∄'
        let g:airline_symbols.whitespace = 'Ξ'
    " }

    " Easemotion {
        let g:EasyMotion_smartcase = 1
        map <Leader><Leader>j <Plug>(easymotion-j)
        map <Leader><Leader>k <Plug>(easymotion-k)
        map <Leader><leader>. <Plug>(easymotion-repeat)
        map <Leader><leader>l <Plug>(easymotion-lineforward)
        map <Leader><leader>h <Plug>(easymotion-linebackward)
    " }

    " Emmet {
        let g:user_emmet_expandabbr_key='<leader><Leader><tab>'
    " }

    if WINDOWS()
    " NeoComplete {
        let g:acp_enableAtStartup = 0
        let g:neocomplete#max_list = 15
        let g:neocomplete#enable_at_startup = 1
        let g:neocomplete#enable_smart_case = 1
        let g:neocomplete#enable_auto_delimiter = 1
        let g:neocomplete#force_overwrite_completefunc = 1

        nmap <Leader><Leader>n :NeoCompleteToggle<CR>
    " }
    endif

    " NerdTree {
        if isdirectory(expand('~/.vim/plugged/nerdtree'))
            map <leader>e :NERDTreeFind<CR>
            map <leader>n :NERDTreeToggle<CR>

            let g:NERDTreeChDirMode=1
            let g:NERDTreeMouseMode=2
            let g:NERDTreeQuitOnOpen=1
            let g:NERDTreeShowHidden=1
            let g:NERDTreeShowBookmarks=1
            let g:NERDTreeKeepTreeInNewTab=1
            let g:nerdtree_tabs_open_on_gui_startup=1
            let g:NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
        endif
    " }

    " Ctrlp-funky {
        nnoremap <Leader>fu :CtrlPFunky<Cr>

        " narrow the list down with a word under cursor
        nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
    " }

    " Tagbar {
        nmap <Leader>t :TagbarToggle<CR>
    " }

    " YouCompleteMe {

        " Disable the neosnippet preview candidate window
        " When enabled, there can be too much visual noise
        " especially when splits are used.
        set completeopt-=preview
        let g:acp_enableAtStartup = 0
        " remap Ultisnips for compatibility for YCM
        let g:UltiSnipsExpandTrigger = '<C-j>'
        let g:UltiSnipsJumpForwardTrigger = '<C-j>'
        let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
        " enable completion from tags
        let g:ycm_collect_identifiers_from_tags_files = 1

        " Enable omni completion.
        augroup vimrc
            autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
            autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
            autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
            autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
            autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
            autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
            autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
        augroup END
    " }

    " Ultisnips {
        " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
        let g:UltiSnipsExpandTrigger='<leader><tab>'
        let g:UltiSnipsJumpBackwardTrigger='<c-z>'
        let g:UltiSnipsJumpForwardTrigger='<c-b>'

        " If you want :UltiSnipsEdit to split your window.
        let g:UltiSnipsEditSplit='vertical'
    " }

    " Ale{
        let g:ale_fixers = {
        \   'javascript':['eslint'],
        \   'SCSS':['prettier'],
        \   'python':['autopep8','isort','yapf']
        \}

        let g:ale_linters = {
        \   'python':['flake8','pylint'],
        \   'SCSS':['prettier','stylelint']
        \}

        let g:ale_linter_aliases = {'CSS': 'SCSS'}

        let g:ale_lint_on_enter=1
        let g:ale_fix_on_save=1
        " let g:ale_lint_on_text_changed='never'
        nmap <silent> <C-k> <Plug>(ale_previous_wrap)
        nmap <silent> <C-j> <Plug>(ale_next_wrap)
    "}
    " Session List {
        set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
        nmap <leader>sl :SessionList<CR>
        nmap <leader>ss :SessionSave<CR>
        nmap <leader>sc :SessionClose<CR>
    " }

    " Indent {
        let g:indent_guides_start_level= 2
        let g:indent_guides_guide_size= 1
        let g:indent_guides_enable_on_vim_startup = 1
    " }

    " Cheat.sh
        " Vim command used to open new buffer
        let g:CheatSheetReaderCmd='new"'

        " Cheat sheet file type
        let g:CheatSheetFt='markdown'

        " Program used to retrieve cheat sheet with its arguments
        let g:CheatSheetUrlGetter='curl --silent'

        " Flag to add cookie file to the query
        let g:CheatSheetUrlGetterIdFlag='-b'

        " cheat sheet base url
        let g:CheatSheetBaseUrl='https://cht.sh'

        " cheat sheet settings do not include style settings neiter comments,
        " see other options below
        let g:CheatSheetUrlSettings='q'

        " cheat sheet pager
        let g:CheatPager='less -R'

        " pygmentize theme used for pager output, see :CheatPager :styles-demo
        "let g:CheatSheetPagerStyle=rrt

        " Show comments in answers by default
        " (setting this to 0 means giving ?Q to the server)
        let g:CheatSheetShowCommentsByDefault=1

        " cheat sheet buffer name
        let g:CheatSheetBufferName="_cheat"

        " Default selection in normal mode (line for whole line, word for word under cursor)
        let g:CheatSheetDefaultSelection="line"

        " Default query mode
        " 0 => buffer
        " 1 => replace (do not use or you might loose some lines of code)
        " 2 => pager
        " 3 => paste after query
        " 4 => paste before query
        let g:CheatSheetDefaultMode=0

         "Path to cheat sheet cookie
        "let g:CheatSheetIdPath=expand('~/.cht.sh/id')
" }

" Backup file {
    set nobackup
    set noswapfile
    set noundofile
    set nowritebackup
" }

" Template {
    "autocmd! BufNewFile *.js,*.jsx 0r ~/.vim/js.tpl
    autocmd! BufNewFile *.js,*.jsx exec ":call SetTpl()"
    function! SetTpl()
        call setline(1         , "/**")
        call append(line(".")  , " * 功能: 模块功能")
        call append(line(".")+1, " * 作者: Deve")
        call append(line(".")+2, " * 日期: ".strftime("%Y-%m-%d"))
        call append(line(".")+3, " */")
    endfunc
" }

" UI {
    if has('gui_running')
        set guicursor=a:block-blinkon0
        set guioptions=

        " Fonts {
            if LINUX()
-                set guifont=Source\ Code\ Pro\ 14
-                set guifontwide=YouYuan\ 14
-            elseif OSX()
-                set guifont=Source\ Code\ Pro:h14
-                set guifontwide=YouYuan:h14
-            elseif WINDOWS()
-                set guifont=Source_Code_Pro:h14
-                set guifontwide=YouYuan:h14
-            endif
        " }
        
        highlight Cursor guifg=black
    endif
" }

" Set Font {
    let g:font={
        \'Inconsolata': {
            \ 'LINUX': 'Inconsolata\ 14',
            \ 'OSX': 'Inconsolata:h14',
            \ 'WINDOWS': 'Inconsolata:h14'
        \ },
        \'SourceCodeProLight': {
            \ 'LINUX': 'Source\ Code\ Pro\ Light\ 14',
            \ 'OSX': 'Source\ Code\ Pro\ Light:h14',
            \ 'WINDOWS': 'Source_Code_Pro_Light:h14'
        \ },
        \'SourceCodePro': {
            \ 'LINUX': 'Source\ Code\ Pro\ 14',
            \ 'OSX': 'Source\ Code\ Pro:h14',
            \ 'WINDOWS': 'Source_Code_Pro:h14'
        \ } 
    \ }

    let g:fontMap={ "in":"Inconsolata", "scp":"SourceCodePro", "scpl":"SourceCodeProLight" }

    function! SetFont(fontName)
        " Fonts {
            if LINUX()
                exec 'set guifont='.g:font[g:fontMap[a:fontName]].LINUX
            elseif OSX()
                exec 'set guifont='.g:font[g:fontMap[a:fontName]].OSX
            elseif WINDOWS()
                exec 'set guifont='.g:font[g:fontMap[a:fontName]].WINDOWS
            endif
        " }
    endfunc
" }
