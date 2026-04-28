return {
  "dnlhc/glance.nvim",
  cmd = "Glance",
  keys = {
    {
      "gd",
      function()
        vim.cmd("Glance definitions")
      end,
      desc = "Glance definitions",
    },
    {
      "gD",
      function()
        vim.cmd("Glance declarations")
      end,
      desc = "Glance declarations",
    },
    {
      "gr",
      function()
        vim.cmd("Glance references")
      end,
      desc = "Glance references",
    },
    {
      "gi",
      function()
        vim.cmd("Glance implementations")
      end,
      desc = "Glance implementations",
    },
    {
      "gt",
      function()
        vim.cmd("Glance type_definitions")
      end,
      desc = "Glance type definitions",
    },
  },
  opts = {},
}
