return {
  "folke/flash.nvim",
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
    },
    {
      "S",
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter()
      end,
    },
    {
      "r",
      mode = "o",
      function()
        require("flash").remote()
      end,
    },
    {
      "R",
      mode = { "o", "x" },
      function()
        require("flash").treesitter_search()
      end,
    },
  },
  opts = {
    search = { mode = "exact" },
  },
}
