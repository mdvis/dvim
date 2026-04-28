return {
  "j-hui/fidget.nvim",
  event = "LspAttach",
  opts = {
    -- LSP 进度通知配置
    progress = {
      display = {
        render_limit = 16,        -- 同时显示的 LSP 消息数量
        done_ttl = 3,             -- 完成消息持续时间（秒）
        done_icon = "✔",          -- 完成图标
        progress_icon = { "dots" }, -- 进度动画
      },
    },
    -- 通知窗口配置
    notification = {
      window = {
        winblend = 0,             -- 窗口透明度 (0-100)
        border = "none",          -- 边框样式
        relative = "editor",      -- 相对位置
      },
    },
  },
}
