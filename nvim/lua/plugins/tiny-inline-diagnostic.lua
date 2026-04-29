return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("tiny-inline-diagnostic").setup({
      preset = "classic",
      options = {
        show_source = true,
        throttle = 20,
      },
    })
  end,
}
