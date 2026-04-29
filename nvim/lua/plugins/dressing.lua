return {
  "stevearc/dressing.nvim",
  opts = {
    input = {
      enabled = true,
    },
    select = {
      enabled = true,
      backend = { "telescope", "fzf", "builtin" },
      builtin = {
        relative = "editor",
        border = "rounded",
        min_height = 10,
        max_height = 0.8,
      },
    },
  },
}
