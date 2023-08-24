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
require('lualine').setup()
require('gitsigns').setup()
require('colorizer').setup()
require('nvim-tree').setup { view = { width = 30 } }
require('bufferline').setup()
require('dashboard').setup{
  theme = 'hyper',
  config = {
    week_header = {
      enable = true,
    },
    shortcut = {
      { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
      {
        icon = ' ',
        icon_hl = '@variable',
        desc = 'Files',
        group = 'Label',
        action = 'Telescope find_files',
        key = 'f',
      },
      {
        desc = ' Apps',
        group = 'DiagnosticHint',
        action = 'Telescope app',
        key = 'a',
      },
      {
        desc = ' dotfiles',
        group = 'Number',
        action = 'Telescope dotfiles',
        key = 'd',
      },
    },
  },
}

vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

require("indent_blankline").setup {
  space_char_blankline = " ",
  show_current_context = true,
  show_current_context_start = true,
}

vim.o.timeout = true
vim.o.timeoutlen = 300

require("which-key").setup {
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

vim.notify = require("notify")
END
