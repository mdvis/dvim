return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- 测试适配器（根据需要添加）
    "nvim-neotest/neotest-python",
    "nvim-neotest/neotest-plenary",
    "nvim-neotest/neotest-vim-test",
    "haydenmeade/neotest-jest",
    "marilari88/neotest-vitest",
    "rouge8/neotest-rust",
  },
  keys = {
    { "<leader>tt", function() require("neotest").run.run() end, desc = "Run nearest test" },
    { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run current file" },
    { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug nearest test" },
    { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
    { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Show test output" },
    { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle output panel" },
    { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop test" },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-python")({
          dap = { justMyCode = false },
          args = { "--log-level", "DEBUG" },
          runner = "pytest",
        }),
        require("neotest-plenary"),
        require("neotest-vim-test")({
          ignore_file_types = { "python", "vim", "lua" },
        }),
        require("neotest-jest")({
          jestCommand = "npm test --",
          jestConfigFile = "custom.jest.config.ts",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        }),
        require("neotest-vitest"),
        require("neotest-rust"),
      },
      -- 状态图标
      icons = {
        running = "",
        passed = "",
        failed = "",
        skipped = "",
        unknown = "",
      },
      -- 浮动窗口配置
      floating = {
        border = "rounded",
        max_height = 0.6,
        max_width = 0.6,
      },
      -- 输出配置
      output = {
        open_on_run = true,
      },
      -- 快速修复配置
      quickfix = {
        enabled = true,
        open = false,
      },
      -- 状态配置
      status = {
        enabled = true,
        virtual_text = true,
        signs = true,
      },
      -- 策略配置
      strategies = {
        integrated = {
          height = 40,
          width = 120,
        },
      },
    })
  end,
}
