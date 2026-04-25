return {
  { "numToStr/Comment.nvim", opts = {} },
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }
      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)
      require("ibl").setup({ indent = { highlight = highlight } })
    end,
  },
  { "mg979/vim-visual-multi", branch = "master" },
  {
    "nvim-mini/mini.align",
    config = function()
      require("mini.align").setup()
    end,
  },
  { "kylechui/nvim-surround", opts = {} },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
        desc = "Open all folds",
      },
      {
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
        desc = "Close all folds",
      },
    },
    opts = {},
    config = function(_, opts)
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      require("ufo").setup(opts)
    end,
  },
  { "folke/persistence.nvim", event = "BufReadPre", opts = {} },
  { "stevearc/aerial.nvim", cmd = { "AerialOpen", "AerialToggle", "AerialNavToggle" }, opts = {} },
  { "mrjones2014/smart-splits.nvim", opts = {} },
  { "s1n7ax/nvim-window-picker", version = "2.*", opts = {} },
  { "folke/snacks.nvim", opts = {} },
}
