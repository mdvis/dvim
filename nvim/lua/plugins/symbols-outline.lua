return {
  "simrat39/symbols-outline.nvim",
  cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
  keys = {
    { "<leader>so", "<cmd>SymbolsOutline<cr>", desc = "Toggle Symbols Outline" },
  },
  opts = {
    -- 高亮当前符号
    highlight_hovered_item = true,
    -- 显示符号指南线
    show_guides = true,
    -- 自动预览
    auto_preview = false,
    -- 位置
    position = "right",
    -- 相对宽度
    relative_width = true,
    -- 宽度
    width = 25,
    -- 自动关闭
    auto_close = false,
    -- 显示数字
    show_numbers = false,
    -- 显示相对数字
    show_relative_numbers = false,
    -- 显示符号详情
    show_symbol_details = true,
    -- 预览背景高亮
    preview_bg_highlight = "Pmenu",
    -- 自动展开
    autofold_depth = nil,
    -- 自动展开深度
    auto_unfold_hover = true,
    -- 折叠标记
    fold_markers = { "", "" },
    -- 换行
    wrap = false,
    -- 快捷键
    keymaps = {
      close = { "<Esc>", "q" },
      goto_location = "<Cr>",
      focus_location = "o",
      hover_symbol = "<C-space>",
      toggle_preview = "K",
      rename_symbol = "r",
      code_actions = "a",
      fold = "h",
      unfold = "l",
      fold_all = "W",
      unfold_all = "E",
      fold_reset = "R",
    },
    -- LSP 黑名单
    lsp_blacklist = {},
    -- 符号黑名单
    symbol_blacklist = {},
    -- 符号图标
    symbols = {
      File = { icon = "", hl = "@text.uri" },
      Module = { icon = "", hl = "@namespace" },
      Namespace = { icon = "", hl = "@namespace" },
      Package = { icon = "", hl = "@namespace" },
      Class = { icon = "𝓒", hl = "@type" },
      Method = { icon = "ƒ", hl = "@method" },
      Property = { icon = "", hl = "@method" },
      Field = { icon = "", hl = "@field" },
      Constructor = { icon = "", hl = "@constructor" },
      Enum = { icon = "", hl = "@type" },
      Interface = { icon = "", hl = "@type" },
      Function = { icon = "", hl = "@function" },
      Variable = { icon = "", hl = "@constant" },
      Constant = { icon = "", hl = "@constant" },
      String = { icon = "𝓐", hl = "@string" },
      Number = { icon = "#", hl = "@number" },
      Boolean = { icon = "", hl = "@boolean" },
      Array = { icon = "", hl = "@constant" },
      Object = { icon = "", hl = "@type" },
      Key = { icon = "🔐", hl = "@type" },
      Null = { icon = "NULL", hl = "@type" },
      EnumMember = { icon = "", hl = "@field" },
      Struct = { icon = "𝓢", hl = "@type" },
      Event = { icon = "🗲", hl = "@type" },
      Operator = { icon = "+", hl = "@operator" },
      TypeParameter = { icon = "𝙏", hl = "@parameter" },
      Component = { icon = "", hl = "@function" },
      Fragment = { icon = "", hl = "@constant" },
    },
  },
}
