return {
  "mg979/vim-visual-multi",
  branch = "master",
  event = "VeryLazy", -- 延迟加载，但确保会被加载
  keys = {
    { "<C-n>", mode = { "n", "x" }, desc = "Start/Add cursor" },
    { "<C-Down>", mode = { "n", "x" }, desc = "Add cursor down" },
    { "<C-Up>", mode = { "n", "x" }, desc = "Add cursor up" },
  },
}
