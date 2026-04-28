return {
  "numToStr/Comment.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    padding = true,
    sticky = true,
    ignore = "^$",
    toggler = {
      line = "gcc",
      block = "gbc",
    },
    opleader = {
      line = "gc",
      block = "gb",
    },
    mappings = {
      basic = true,
      extra = true,
    },
  },
}
