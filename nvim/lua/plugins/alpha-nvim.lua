return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local startify = require("alpha.themes.startify")
    startify.section.header.val = { "DEVE" }
    require("alpha").setup(startify.config)
  end,
}
