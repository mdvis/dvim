" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker:
scriptencoding utf-8
" .config/nvim/init.vim
"
" ~/.vimrc
" ~/.vimrc.conf
" ~/.vimrc.custom
" ~/.vimrc.maps
" ~/.vimrc.plugins
"
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

lua << END
vim.opt.termguicolors = true

require('hop').setup()
require('gitsigns').setup()
require('colorizer').setup()
require('bufferline').setup()
require("nvim-autopairs").setup {}

vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

require("indent_blankline").setup {
  space_char_blankline = " ",
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
    "IndentBlanklineIndent3",
    "IndentBlanklineIndent4",
    "IndentBlanklineIndent5",
    "IndentBlanklineIndent6",
    },
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash", "c", "c_sharp", "csv", "css", "diff", "cmake", "lua", "vim",
    "vimdoc", "query", "typescript", "tsx", "toml", "sql", "rust", "scss",
    "python", "vim", "vimdoc", "vue", "yaml", "xml", "make", "markdown",
    "markdown_inline", "lua", "lua", "luadoc", "luap", "luau", "dockerfile",
    "go", "gomod", "gosum", "gowork", "graphql", "html", "http", "java",
    "javascript", "jsdoc", "json", "json5", "git_config", "git_rebase",
    "gitcommit", "gitignore"
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

vim.cmd([[
    hi BqfPreviewBorder guifg=#3e8e2d ctermfg=71
    hi BqfPreviewTitle guifg=#3e8e2d ctermfg=71
    hi BqfPreviewThumb guibg=#3e8e2d ctermbg=71
    hi link BqfPreviewRange Search
]])

require('bqf').setup({
    auto_enable = true,
    auto_resize_height = true, -- highly recommended enable
    preview = {
        win_height = 12,
        win_vheight = 12,
        delay_syntax = 80,
        border = {'┏', '━', '┓', '┃', '┛', '━', '┗', '┃'},
        show_title = false,
        should_preview_cb = function(bufnr, qwinid)
            local ret = true
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            local fsize = vim.fn.getfsize(bufname)
            if fsize > 100 * 1024 then
                -- skip file size greater than 100k
                ret = false
            elseif bufname:match('^fugitive://') then
                -- skip fugitive buffer
                ret = false
            end
            return ret
        end
    },
    -- make `drop` and `tab drop` to become preferred
    func_map = {
        drop = 'o',
        openc = 'O',
        split = '<C-s>',
        tabdrop = '<C-t>',
        -- set to empty string to disable
        tabc = '',
        ptogglemode = 'z,',
    },
    filter = {
        fzf = {
            action_for = {['ctrl-s'] = 'split', ['ctrl-t'] = 'tab drop'},
            extra_opts = {'--bind', 'ctrl-o:toggle-all', '--prompt', '> '}
        }
    }
})

vim.notify = require("notify")
END
