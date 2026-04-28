return {
  "stevearc/conform.nvim",
  cmd = "ConformInfo",
  opts = {
    formatters_by_ft = {
      go = { "goimports", "gofumpt" },
      rust = { "rustfmt" },
      python = { "ruff_format", "black" },
      lua = { "stylua" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      zsh = { "shfmt" },
      javascript = { "prettierd", "prettier" },
      javascriptreact = { "prettierd", "prettier" },
      typescript = { "prettierd", "prettier" },
      typescriptreact = { "prettierd", "prettier" },
    },
    format_on_save = function(bufnr)
      return {
        timeout_ms = 1200,
        lsp_format = "fallback",
        bufnr = bufnr,
      }
    end,
  },
}
