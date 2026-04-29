return {
  "stevearc/aerial.nvim",
  cmd = { "AerialOpen", "AerialToggle", "AerialNavToggle" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    backends = { "treesitter", "lsp", "markdown", "man" },
    layout = {
      max_width = { 40, 0.2 },
      width = nil,
      min_width = 20,
      default_direction = "prefer_right",
    },
    attach_mode = "window",
    close_automatic_events = { "unfocus" },
    show_guides = true,
    guides = {
      mid_item = "├─",
      last_item = "└─",
      nested_top = "│ ",
      whitespace = "  ",
    },
    filter_kind = false,
    highlight_on_hover = true,
    autojump = false,
  },
  -- keys = {
  --   { "<leader>a", "<cmd>AerialToggle<cr>", desc = "Toggle Aerial" },
  --   { "<leader>A", "<cmd>AerialNavToggle<cr>", desc = "Toggle Aerial Nav" },
  --   { "{", "<cmd>AerialPrev<cr>", desc = "Aerial Prev" },
  --   { "}", "<cmd>AerialNext<cr>", desc = "Aerial Next" },
  -- },
}
