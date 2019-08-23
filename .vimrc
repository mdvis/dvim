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

let g:mapleader = ','

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

" General {
    " File {
        filetype plugin indent on
        syntax on
        set mouse= " a
        set mousehide
    " }
    set clipboard=unnamed
    " Better Unix / Windows compatibility
    set viewoptions=folds,options,cursor,unix,slash
" }

" UI {
    set shortmess=atI
    set cursorline     " Highlight current line
    set cursorcolumn   " Highlight current column
    set textwidth=80
    set colorcolumn=80
    set list
    set listchars=tab:>-,trail:-
    set showtabline=2
    set laststatus=2
    " Status Line {
      if has('statusline')
        hi User1 cterm=None ctermfg=244 ctermbg=236 guifg=#808080 guibg=#303030
        hi User2 cterm=None ctermfg=245 ctermbg=237 guifg=#8a8a8a guibg=#3a3a3a
        hi User5 cterm=None ctermfg=172 ctermbg=236 guifg=#fd971f guibg=#303030

        set statusline=%5*%r              " Readonly
        set statusline+=%1*%F             " Path
        set statusline+=%5*%m\ %*         " Modify
        set statusline+=%2*\ %l/%c\ %*     " Line/Coloumn
        set statusline+=%=                " Placeholder
        set statusline+=%1*\ %{&ff}\ %*   " Format
        set statusline+=%2*\ %{&fenc}\ %* " Encode
      endif
    " }
    " Behavior {
        set showcmd
        set expandtab             " Tabs are spaces, not tabs
        set tabstop=2             " Number of spaces that a <Tab> in the file counts for.
        set shiftwidth=2          " Number of spaces to use for each step of (auto)indent
        set softtabstop=2         " Number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>.
        set backspace=indent,eol,start
        set whichwrap=b,s,<,>,[,] " Move to the prev/next line when the cursor is on the first/last character
        set formatoptions=tqmM
        set foldmethod=marker
        set foldmarker={,}
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
        set scrolljump=4
        set scrolloff=4
        set cmdheight=2
        set wildmenu                    " Show list instead of just completing
        set wildmode=list:longest,full  " Command <Tab> completion, list matches
    " }

    " Colors {
        if filereadable(expand('~/.vim/colors/gruvbox.vim'))
            let g:gruvbox_contrast_dark='hard'
            colorscheme gruvbox
            set background=dark
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
    " Tagbar {
      nmap <leader>t :TagbarToggle<CR>
    " }
    " Easy align {
      map ga <Plug>(EasyAlign)
    " }
    " deoplete {
        let g:deoplete#enable_at_startup = 1
    " }
    " Rainbow {
        let g:rainbow_active=1
    " }
    " Easemotion {
        let g:EasyMotion_smartcase = 1
        map <Leader><Leader>s <Plug>(easymotion-s)
        map <Leader><Leader>j <Plug>(easymotion-j)
        map <Leader><Leader>k <Plug>(easymotion-k)
        map <Leader><leader>. <Plug>(easymotion-repeat)
        map <Leader><leader>l <Plug>(easymotion-lineforward)
        map <Leader><leader>h <Plug>(easymotion-linebackward)
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
        let g:NERDTreeDirArrowExpandable = '+'
        let g:NERDTreeDirArrowCollapsible = '-'
        map <leader>e :NERDTreeFind<CR>
        map <leader>n :NERDTreeTabsToggle<CR>
    " }
    " fzf {
        let g:fzf_action = {
                    \ 'ctrl-e': 'edit',
                    \ 'ctrl-t': 'tab split',
                    \ 'ctrl-x': 'split',
                    \ 'ctrl-v': 'vsplit' }
        nmap <C-p> :Files<CR>
        nmap <C-e> :Buffers<CR>
    " }
    " Ultisnips {
        let g:UltiSnipsExpandTrigger='<tab>'
        let g:UltiSnipsJumpBackwardTrigger='<c-j>'
        let g:UltiSnipsJumpForwardTrigger='<c-k>'
        let g:UltiSnipsEditSplit='vertical'
    " }
    " IndentLine {
        let g:indentLine_concealcursor='inc'
        let g:indentLine_conceallevel=2
    " }
    " Prettier{
        let g:prettier#autoformat = 0
        let g:prettier#quickfix_enabled = 0
        let g:prettier#config#tab_width = 2
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
                    \   'javascript':['eslint'],
                    \   'typescript':['eslint'],
                    \   'python':['flake8', 'pylint'],
                    \   'vim':['vim-vint']}
        let g:ale_lint_on_enter=1
        let g:ale_fix_on_save=1
        nmap <silent> <C-k> <Plug>(ale_previous_wrap)
        nmap <silent> <C-j> <Plug>(ale_next_wrap)
    " }
    " Backup file {
         set nobackup
         set noswapfile
         set noundofile
         set nowritebackup
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

" Mappings {
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
