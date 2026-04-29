local function lsp_capabilities()
  local caps = vim.lsp.protocol.make_client_capabilities()
  local ok, blink = pcall(require, "blink.cmp")
  if ok and blink.get_lsp_capabilities then
    return blink.get_lsp_capabilities(caps)
  end
  return caps
end

return {
  "mason-org/mason-lspconfig.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
  opts = {
    ensure_installed = {
      "bashls",
      "eslint",
      "jsonls",
      "lua_ls",
      "pyright",
      "rust_analyzer",
      "ts_ls",
      "gopls",
      "marksman",
      "taplo",
      "yamlls",
    },
    -- automatic_enable = true,
  },
  config = function(_, opts)
    if vim.lsp and vim.lsp.config then
      vim.lsp.config("*", {
        capabilities = lsp_capabilities(),
      })
    end
    require("mason-lspconfig").setup(opts)
  end,
}
