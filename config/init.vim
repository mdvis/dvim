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

-- require('lualine').setup()
require'nvim-tree'.setup()
require'colorizer'.setup()
require("bufferline").setup{}
require('gitsigns').setup()
require('dashboard').setup()

vim.notify = require("notify")
END
