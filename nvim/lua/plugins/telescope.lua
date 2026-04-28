return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "xiyaowong/telescope-emoji.nvim",
  },
  keys = {
    { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>fe", "<cmd>Telescope emoji<cr>", desc = "Emoji" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        -- 可选：美化界面
        prompt_prefix = "🔍 ",
        selection_caret = "➤ ",
        
        -- 可选：忽略文件（默认已经忽略 .git）
        file_ignore_patterns = { "node_modules", "%.lock" },
        
        -- 可选：自定义快捷键（默认已有 Ctrl-n/p 上下移动）
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<esc>"] = actions.close,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true, -- 显示隐藏文件
        },
      },
    })

    -- 加载扩展
    pcall(telescope.load_extension, "emoji")
    pcall(telescope.load_extension, "fzf")
  end,
}
