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
    set tildeop                   "~motion
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
    if has('statusline')
        set laststatus=2
        " set statusline=
    endif
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
        set visualbell " visual error bell
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

" Auto load vimrc {
    autocmd! bufwritepost $MYVIMRC source $MYVIMRC
" }

" Plugin Config Start {
    " js {
        let g:javascript_plugin_jsdoc=1
    " }

    " Rainbow {
        let g:rainbow_active=1
    " }

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
    " }
    " Emmet {
        let g:user_emmet_expandabbr_key='<leader><Leader><tab>'
    " }
    " NerdTree {
        let g:NERDTreeWinSize=30
        let g:NERDTreeChDirMode=1
        let g:NERDTreeMouseMode=2
        let g:NERDTreeQuitOnOpen=1
        let g:NERDTreeShowHidden=1
        let g:NERDTreeShowBookmarks=1
        let g:NERDTreeKeepTreeInNewTab=1
        let g:nerdtree_tabs_open_on_gui_startup=1
        let g:NERDTreeIgnore=[
                    \ '\.py[cd]$', '\~$', '\.swo$',
                    \ '\.swp$', '^\.git$', '^\.hg$',
                    \ '^\.svn$', '\.bzr$', '^\.DS_Store',
                    \ 'node_modules']
        let g:NERDTreeIndicatorMapCustom = {
            \ "Modified"  : "*",
            \ "Staged"    : "+",
            \ "Untracked" : "✭",
            \ "Renamed"   : "➜",
            \ "Unmerged"  : "═",
            \ "Deleted"   : "x",
            \ "Dirty"     : "✗",
            \ "Clean"     : "✔︎",
            \ 'Ignored'   : '☒',
            \ "Unknown"   : "?" }
    " }
    " fzf {
        let g:fzf_action = {
                    \ 'ctrl-e': 'edit',
                    \ 'ctrl-t': 'tab split',
                    \ 'ctrl-x': 'split',
                    \ 'ctrl-v': 'vsplit' }
    " }
    " YouCompleteMe {
        set completeopt-=preview
        let g:acp_enableAtStartup = 0
        " enable completion from tags
        let g:ycm_collect_identifiers_from_tags_files = 1
        " Enable omni completion.
        autocmd FileType html,markdown
                    \ setlocal omnifunc=htmlcomplete#CompleteTags
        " autocmd FileType javascript
        "            \ setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType javascript setlocal omnifunc=tern#Complete
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
        autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
    " }
    " Ultisnips {
        let g:UltiSnipsExpandTrigger='<leader><tab>'
        let g:UltiSnipsJumpBackwardTrigger='<c-j>'
        let g:UltiSnipsJumpForwardTrigger='<c-k>'
        let g:UltiSnipsEditSplit='vertical'
    " }
    " IndentLine {
        let g:indentLine_concealcursor=''
        let g:indentLine_conceallevel=2
    " }
    " Prettier{
        let g:prettier#autoformat = 0
        let g:prettier#quickfix_enabled = 0
        let g:prettier#config#tab_width = 4
        autocmd BufWritePre *.vue,*.css,*.less,*.scss PrettierAsync
    " }
    " Ale {
        " pip3 install flake8 pylint vim-vint autopep8 isort yapf
        let g:ale_fixers = {
                    \   '*': ['remove_trailing_lines', 'trim_whitespace'],
                    \   'go':['gofmt'],
                    \   'javascript':['eslint'],
                    \   'typescript':['eslint'],
                    \   'python':['autopep8', 'isort', 'yapf']}

        let g:ale_linters = {
                    \   'python':['flake8', 'pylint'],
                    \   'vim':['vim-vint']}
        let g:ale_lint_on_enter=1
        let g:ale_fix_on_save=1
    " }
    " Vim-repeat {
      silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)
    " }
    " Backup file {
        set backup
        set swapfile
        set undofile
        set writebackup
        "set nobackup
        "set noswapfile
        "set noundofile
        "set nowritebackup
        " 结尾的//表示生成的文件名带有绝对路径
        " 路径中用%替换目录分隔符，这样可以防止文件重名
        if WINDOWS()
            set backupdir=c:\backup\\
            set directory=c:\swp\\
            set undodir=c:\undo\\
        else
            set backupdir=~/.backup//
            set directory=~/.swp//
            set undodir=~/.undo//
        endif
    " }
    " UI {
        if has('gui_running')
            set guicursor=a:block-blinkon0
            set guioptions=
            " Fonts { Source\ Code\ Pro\ 16
            if LINUX()
                set guifont=SauceCodePro\ Nerd\ Font\ 16
                set guifontwide=YouYuan\ 16
            elseif OSX()
                set guifont=SauceCodePro\ Nerd\ Font:h16
                set guifontwide=YouYuan:h16
            elseif WINDOWS()
                set guifont=SauceCodePro_Nerd_Font:h16
                set guifontwide=YouYuan:h16
            endif
            " }
        endif
    " }
" }
let g:mapleader = ','
" Mappings {
    nmap <leader>sw :mksession! ~/.my.vim<CR>
    nmap <leader>sr :source ~/.my.vim<CR>
    nmap <leader>r :reg<CR>
    nmap <leader>N :noh<CR>
    nmap <leader>J :JsDoc<CR>
    nmap <leader>w :w<CR>
    nmap <leader>q :q<CR>
    nmap <leader>h <c-w>h
    nmap <leader>j <c-w>j
    nmap <leader>k <c-w>k
    nmap <leader>l <c-w>l
    nmap j gj
    nmap k gk
    nmap <leader>t :TagbarToggle<CR>
    " Easemotion {
        map <Leader><Leader>j <Plug>(easymotion-j)
        map <Leader><Leader>k <Plug>(easymotion-k)
        map <Leader><leader>. <Plug>(easymotion-repeat)
        map <Leader><leader>l <Plug>(easymotion-lineforward)
        map <Leader><leader>h <Plug>(easymotion-linebackward)
    " }
    " Nerdtree {
        map <leader>e :NERDTreeFind<CR>
        map <leader>n :NERDTreeTabsToggle<CR>
    " }
    " Ale {
        nmap <silent> <C-k> <Plug>(ale_previous_wrap)
        nmap <silent> <C-j> <Plug>(ale_next_wrap)
    " }
    " FZF {
        nmap <C-p> :Files<CR>
        nmap <C-e> :Buffers<CR>
    " }
    " Signify {
        " this first setting decides in which order try to guess your current vcs
        " UPDATE it to reflect your preferences, it will speed up opening files
        let g:signify_vcs_list = [ 'git' ]
        " mappings to jump to changed blocks
        nmap <leader>sn <plug>(signify-next-hunk)
        nmap <leader>sp <plug>(signify-prev-hunk)
        " nicer colors
        highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
        highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
        highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
        highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
        highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
        highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227
    " }
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
