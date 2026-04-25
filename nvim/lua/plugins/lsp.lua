local function lsp_capabilities()
  local caps = vim.lsp.protocol.make_client_capabilities()
  local ok, blink = pcall(require, "blink.cmp")
  if ok and blink.get_lsp_capabilities then
    return blink.get_lsp_capabilities(caps)
  end
  return caps
end

return {
  { "j-hui/fidget.nvim", event = "LspAttach", opts = {} },
  { "folke/trouble.nvim", cmd = "Trouble", opts = {} },
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonLog", "MasonUpdate" },
    opts = {},
  },
  {
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
        "taplo",
        "yamlls",
      },
      automatic_enable = true,
    },
    config = function(_, opts)
      if vim.lsp and vim.lsp.config then
        vim.lsp.config("*", {
          capabilities = lsp_capabilities(),
        })
      end
      require("mason-lspconfig").setup(opts)
    end,
  },
  { "neovim/nvim-lspconfig" },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    cmd = { "MasonToolsInstall", "MasonToolsInstallSync", "MasonToolsUpdate", "MasonToolsClean" },
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        "bash-debug-adapter",
        "black",
        "codelldb",
        "debugpy",
        "delve",
        "eslint_d",
        "gofumpt",
        "goimports",
        "golangci-lint",
        "luacheck",
        "prettier",
        "prettierd",
        "ruff",
        "shellcheck",
        "shfmt",
        "stylua",
      },
      auto_update = false,
      run_on_start = true,
      start_delay = 2500,
      debounce_hours = 12,
    },
  },
  {
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
  },
  {
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
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  { "rafamadriz/friendly-snippets" },
  { "mrcjkb/rustaceanvim", ft = "rust" },
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = { "nvim-neo-tree/neo-tree.nvim", "neovim/nvim-lspconfig" },
    config = true,
  },
}
