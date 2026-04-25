return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      render = "compact",
      stages = "slide",
      timeout = 3000,
    },
  },
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      local startify = require("alpha.themes.startify")
      startify.section.header.val = { "DEVE" }
      require("alpha").setup(startify.config)
    end,
  },
  { "nvim-lualine/lualine.nvim", event = "VeryLazy", opts = {} },
  { "akinsho/bufferline.nvim", version = "*", event = "VeryLazy", opts = {} },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
