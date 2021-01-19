" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker:
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
  augroup loadConf
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
  augroup END
" }

" General {
    " File {
        filetype plugin indent on
        syntax on
        set mouse=a
        "set mousehide
    " }
    set clipboard=unnamed
    " Better Unix/Windows compatibility
    set viewoptions=folds,options,cursor,unix,slash
" }

" UI {
    " Colors {
        if filereadable(expand('~/.vim/colors/gruvbox.vim'))
            let g:gruvbox_contrast_dark='hard'
            colorscheme gruvbox
            set background=dark
        endif
    " }

    set shortmess=atI
    set cursorline     " Highlight current line
    set cursorcolumn   " Highlight current column
    set textwidth=80
    set colorcolumn=80
    set list
    set listchars=tab:>-,trail:-
    set showtabline=2
    set laststatus=2
    " Behavior {
        set noerrorbells
        set visualbell
        set showcmd
        set expandtab             " Tabs are spaces, not tabs
        set tabstop=4             " Number of spaces that a <Tab> in the file counts for.
        set shiftwidth=4          " Number of spaces to use for each step of (auto)indent
        set softtabstop=4         " Number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>.
        set whichwrap=b,s,<,>,[,] " Move to the prev/next line when the cursor is on the first/last character
        set backspace=indent,eol,start
        set formatoptions=tqmM
        set foldmethod=manual
        set nofoldenable
        set splitbelow " splitting a window will put the new window blow of the current one
        set splitright " splitting a window will put the new window right of the current one
        set autoindent " Indent at the same level of the previous line
        set ignorecase " Case insensitive search
        set smartcase  " Case sensitive when uc present
        set showmatch  " Show matching brackets/parenthesis
        set incsearch  " Find as you type search
        set autochdir
        set autoread
        set hlsearch
        set nowrap
        set number
        set sidescrolloff=4
        set scrolljump=2
        set scrolloff=2
        set cmdheight=2
        set wildmenu                   " Show list instead of just completing
        set wildmode=list:longest,full " Command <Tab> completion, list matches
    " }

    " Status Line {
      if has('statusline')
        hi User1 cterm=None ctermfg=160 ctermbg=236 guifg=#d70000 guibg=#303030 " warning
        hi User2 cterm=None ctermfg=236 ctermbg=240 guifg=#303030 guibg=#585858
        hi User3 cterm=None ctermfg=240 ctermbg=236 guifg=#585858 guibg=#303030

        set statusline=%<%1*%r%*          " Readonly
        set statusline+=%1*%m%*           " Modify
        set statusline+=%3*%F%*           " Path
        set statusline+=%2*\ %l/%c\ %*    " Line/Coloumn
        set statusline+=%3*\ %p%%\ %*     " Line/Coloumn
        set statusline+=%=                " Placeholder
        set statusline+=%3*\ %{&ff}\ %*   " Format
        set statusline+=%2*\ %{&fenc}\ %* " Encode
      endif
    " }
" }

" Encode {
    set termencoding=utf-8
    set encoding=utf-8
    scriptencoding utf-8
    setglobal fileencoding=utf-8
    set fileencodings=utf-8,ucs-bom,utf-16le,cp1252,iso-8859-15

    if has('win32')
        source $VIMRUNTIME/vimrc_example.vim
        " menu error code
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim
        " console output error code
        language messages zh_CN.utf-8
    endif
" }

" Plugin Config Start {
    " Signify {
        " this first setting decides in which order try to guess your current vcs
        " UPDATE it to reflect your preferences, it will speed up opening files
        let g:signify_vcs_list = [ 'git' ]
        " nicer colors
        highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
        highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
        highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
        highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
        highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
        highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227
    " }
    " Rainbow {
        let g:rainbow_active=1
    " }
    " Easemotion {
        let g:EasyMotion_smartcase = 1
    " }
    " Emmet {
        let g:user_emmet_expandabbr_key='<leader><Leader><tab>'
    " }
    " NerdTree {
        " let g:NERDTreeWinSize=30
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
                    \ 'node_modules', '\.meta$', '\.fire$']
        let g:NERDTreeGitStatusIndicatorMapCustom = {
            \ 'Modified'  : '*',
            \ 'Staged'    : '+',
            \ 'Untracked' : '✭',
            \ 'Renamed'   : '➜',
            \ 'Unmerged'  : '═',
            \ 'Deleted'   : 'x',
            \ 'Dirty'     : '✗',
            \ 'Clean'     : '✔︎',
            \ 'Ignored'   : '☒',
            \ 'Unknown'   : '?' }
        let g:NERDTreeDirArrowExpandable = '+'
        let g:NERDTreeDirArrowCollapsible = '-'
    " }
    " fzf {
        let g:fzf_action = {
                    \ 'ctrl-e': 'edit',
                    \ 'ctrl-t': 'tab split',
                    \ 'ctrl-x': 'split',
                    \ 'ctrl-v': 'vsplit' }
    " }
    " Ultisnips {
        let g:UltiSnipsExpandTrigger='<leader><tab>'
        let g:UltiSnipsJumpBackwardTrigger='<c-j>'
        let g:UltiSnipsJumpForwardTrigger='<c-k>'
        let g:UltiSnipsEditSplit='vertical'
    " }
    " IndentLine {
        let g:indentLine_concealcursor='inc'
        let g:indentLine_conceallevel=2
    " }
    " Ale {
        let g:ale_fixers = {
                    \   '*': ['remove_trailing_lines', 'trim_whitespace'],
                    \   'go':['gofmt', 'goimports'],
                    \   'python':['autopep8', 'isort', 'yapf'],
                    \   'javascript':['eslint'],
                    \   'typescript':['eslint'],
                    \   'vue':['eslint'],
                    \   'scss':['stylelint'],
                    \   'css':['stylelint'],
                    \   'json':['prettier']}

        let g:ale_linters = {
                    \   'go':['gometalinter', 'gofmt'],
                    \   'python':['flake8', 'pylint'],
                    \   'javascript':['eslint'],
                    \   'typescript':['eslint'],
                    \   'vue':['eslint'],
                    \   'scss':['stylelint'],
                    \   'css':['stylelint'],
                    \   'json':['jsonlint'],
                    \   'sh':['shellcheck'],
                    \   'vim':['vint']}
        let g:ale_lint_on_insert_leave=1
        let g:ale_lint_on_enter=1
        let g:ale_fix_on_save=1
    " }
    " YouCompleteMe {
        set completeopt-=preview
        let g:acp_enableAtStartup = 0
        " enable completion from tags
        let g:ycm_collect_identifiers_from_tags_files = 1
        " Enable omni completion.
        augroup YCM
          autocmd FileType html,markdown
                      \ setlocal omnifunc=htmlcomplete#CompleteTags
          " autocmd FileType javascript
          "            \ setlocal omnifunc=javascriptcomplete#CompleteJS
          autocmd FileType javascript setlocal omnifunc=tern#Complete
          autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
          autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
          autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        augroup end
    " }
    " Ack {
        let g:ackprg = 'ag --nogroup --nocolor --column'
    " }
    " Backup file {
        set backup
        set swapfile
        set undofile
        set writebackup
        " set nobackup
        " set noswapfile
        " set noundofile
        " set nowritebackup
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
            " Fonts {
            if LINUX()
                set guifont=Fira\ Code\ 24, SauceCodePro\ Nerd\ Font\ 24
            elseif OSX()
                set guifont=Fira\ Code:h24, SauceCodePro\ Nerd\ Font:h24
            elseif WINDOWS()
                set guifont=Fira_Code:h24, SauceCodePro_Nerd_Font:h24
            endif
            " }
        endif
        if exists('g:GuiLoaded')
            set guifont=Fira\ Code:h24
        endif
    " }
" }

" Mappings {
    let g:mapleader = ','
    map <silent> <Leader>S :source $MYVIMRC<CR>
    " Ale {
        nmap <silent> <C-k> <Plug>(ale_previous_wrap)
        nmap <silent> <C-j> <Plug>(ale_next_wrap)
    " }
    " fzf {
        nmap <C-p> :Files<CR>
        nmap <C-e> :Buffers<CR>
    " }
    " NerdTree {
        map <leader>e :NERDTreeFind<CR>
        map <leader>n :NERDTreeTabsToggle<CR>

        " custom
        map <leader>c :NERDTree ~/Code<CR>
        map <leader>i :NERDTree ~/ipalfish<CR>
    " }
    " Easemotion {
        nmap <Leader><Leader>s <Plug>(easymotion-s)
        nmap <Leader><Leader>j <Plug>(easymotion-j)
        nmap <Leader><Leader>k <Plug>(easymotion-k)
        nmap <Leader><leader>l <Plug>(easymotion-lineforward)
        nmap <Leader><leader>h <Plug>(easymotion-linebackward)
    " }
    " Signify {
        " mappings to jump to changed blocks
        nmap <leader>sn <plug>(signify-next-hunk)
        nmap <leader>sp <plug>(signify-prev-hunk)
    " }
    " Tagbar {
        nmap <leader>t :TagbarToggle<CR>
    " }
    nmap <silent> <leader>jd <Plug>(jsdoc)
    nmap <leader><leader>a :Ack<space>
    nmap <leader><leader>A :Ag<space>

    nmap <leader><leader>o :browse oldfiles<CR>
    nmap <leader><leader>t :tabs<CR>
    nmap <leader><leader>r :reg<CR>
    nmap <leader>nh :noh<CR>
    nmap <leader>s :term<CR>
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

:abclear
:ab jsxc {/* !cursor! */}<Esc>:call search('!cursor!','b')<CR>cf!

augroup wechat
  autocmd!
  autocmd BufRead,BufNewFile *.wxss set filetype=css
  autocmd BufRead,BufNewFile *.wxml set filetype=html
augroup END
