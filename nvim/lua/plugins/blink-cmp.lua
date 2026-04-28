return {
  "saghen/blink.cmp",
  version = "v1.*",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
  },
  opts = {
    keymap = { preset = "super-tab" },
    appearance = { nerd_font_variant = "mono" },
    snippets = { preset = "luasnip" },
    completion = {
      trigger = {
        show_on_trigger_character = true,
        show_on_keyword = true,
      },
      documentation = { auto_show = false },
    },
    sources = { default = { "lsp", "path", "snippets", "buffer" } },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
}
